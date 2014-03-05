part of net;

// see: https://github.com/bestiejs/punycode.js/blob/master/punycode.js

const int _MAX_32_BIT_INT = 2147483647;
const int _INITIAL_N = 128;

/** Bootstring parameters */
const int _BASE = 36;
const int _T_MIN = 1;
const int _T_MAX = 26;
const int _SKEW = 38;
const int _DAMP = 700;
const int _INITIAL_BIAS = 72;
const String _DELIMITER = '-'; // '\x2D'
const int _BASE_MINUS_T_MIN = _BASE - _T_MIN;

/**
 * Bias adaptation function as per section 3.4 of RFC 3492.
 * http://tools.ietf.org/html/rfc3492#section-3.4
 * @private
 */
int _adapt(int delta, final int numPoints, final bool firstTime) {
  delta = firstTime ? (delta / _DAMP).floor() : delta >> 1;
  delta += (delta / numPoints).floor();
  
  int k;
  for (k = 0; delta > _BASE_MINUS_T_MIN * _T_MAX >> 1; k += _BASE) {
    delta = (delta / _BASE_MINUS_T_MIN).floor();
  }
  return (k + (_BASE_MINUS_T_MIN + 1) * delta / (delta + _SKEW)).floor();
}

/**
 * Converts a digit/integer into a basic code point.
 * @see `basicToDigit()`
 * @private
 * @param {Number} digit The numeric value of a basic code point.
 * @returns {Number} The basic code point whose value (when used for
 * representing integers) is `digit`, which needs to be in the range
 * `0` to `base - 1`. If `flag` is non-zero, the uppercase form is
 * used; else, the lowercase form is used. The behavior is undefined
 * if `flag` is non-zero and `digit` has no uppercase form.
 */
int _digitToBasic(final int digit, final bool flag) {
  //  0..25 map to ASCII a..z or A..Z
  // 26..35 map to ASCII 0..9
  
  return digit + 22 + 75 * (digit < 26 ? 1 : 0) - ((flag ? 1 : 0) << 5);
}

int _basicToDigit(final int codePoint) {
  if (codePoint - 48 < 10) {
    return codePoint - 22;
  }
  if (codePoint - 65 < 26) {
    return codePoint - 65;
  }
  if (codePoint - 97 < 26) {
    return codePoint - 97;
  }
  return _BASE;
}

String _toASCII(final String domain) {
  return "xn--" + _encode(domain);
}

String _encode(final String str) {
  final Runes runes = str.runes;
  final StringBuffer buffer = new StringBuffer();
  
  for (final int rune in runes) {
    if (rune < 0x80) {
      buffer.writeCharCode(rune);
    }
  }
  
  final int basicLength = buffer.length;
  int handledCPCount = buffer.length;
  
  if (buffer.isNotEmpty) {
    buffer.write("-");
  }
  
  // Initialize the state
  int n = _INITIAL_N;
  int delta = 0;
  int bias = _INITIAL_BIAS;
  
  while (handledCPCount < runes.length) {

    // All non-basic code points < n have been handled already. Find the next
    // larger one:
    int m = _MAX_32_BIT_INT;
    for (final int rune in runes) {
      if(rune >= n && rune < m) {
        m = rune;
      }
    }

    // Increase `delta` enough to advance the decoder's <n,i> state to <m,0>,
    // but guard against overflow
    final int handledCPCountPlusOne = handledCPCount + 1;
    if (m - n > ((_MAX_32_BIT_INT - delta) / handledCPCountPlusOne).floor()) {
      // FIXME: Maybe return Option instead
      throw new StateError("overflow");
    }

    delta += (m - n) * handledCPCountPlusOne;
    n = m;
    
    for (final int rune in runes) {
      if (rune < n && ++delta > _MAX_32_BIT_INT) {
        // FIXME: Maybe return Option instead
        throw new StateError("overflow");
      }

      if (rune == n) {
        // Represent delta as a generalized variable-length integer
        int q = delta;
        
        for (int k = _BASE; /* no condition */; k += _BASE) {
          int t = k <= bias ? _T_MIN : (k >= bias + _T_MAX ? _T_MAX : k - bias);
          if (q < t) {
            break;
          }
          
          final int qMinusT = q - t;
          final int baseMinusT = _BASE - t;
          
          buffer.writeCharCode(_digitToBasic(t + qMinusT % baseMinusT, false));
          q = (qMinusT / baseMinusT).floor();
        }

        buffer.writeCharCode(_digitToBasic(q, false));

        bias = _adapt(delta, handledCPCountPlusOne, handledCPCount == basicLength);
        delta = 0;
        ++handledCPCount;
      }
    }

    ++delta;
    ++n;
  }
  
  return buffer.toString();
}

String _toUnicode(final String domain) {
  if (domain.startsWith("xn--")) {
    return _decode(domain.substring(4));
  }
  
  return domain;
}



/**
 * Converts a Punycode string of ASCII-only symbols to a string of Unicode
 * symbols.
 * @memberOf punycode
 * @param {String} input The Punycode string of ASCII-only symbols.
 * @returns {String} The resulting string of Unicode symbols.
 */
String _decode(final String input) {
  final List<int> buffer = new List();
  // Handle the basic code points: let `basic` be the number of input code
  // points before the last delimiter, or `0` if there is none, then copy
  // the first basic code points to the output.
  int basic = input.lastIndexOf(_DELIMITER);
  
  if (basic < 0) {
    basic = 0;
  }

  for (int j = 0; j < basic; ++j) {
    // if it's not a basic code point
    if (input.codeUnitAt(j) >= 0x80) {
      throw new ArgumentError('not-basic');
    }
    buffer.add(input.codeUnitAt(j));
  }

  // Main decoding loop: start just after the last delimiter if any basic code
  // points were copied; start at the beginning otherwise.

  int i = 0;
  int n = _INITIAL_N;
  int bias = _INITIAL_BIAS;
  
  for (int index = basic > 0 ? basic + 1 : 0; index < input.length; /* no final expression */) {

    // `index` is the index of the next character to be consumed.
    // Decode a generalized variable-length integer into `delta`,
    // which gets added to `i`. The overflow checking is easier
    // if we increase `i` as we go, then subtract off its starting
    // value at the end to obtain `delta`.

    int oldi = i, w = 1, k = _BASE;
    for (; /* no condition */; k += _BASE) {

      if (index >= input.length) {
        throw new ArgumentError('invalid-input');
      }

      int digit = _basicToDigit(input.codeUnitAt(index++));

      if (digit >= _BASE || digit > ((_MAX_32_BIT_INT - i) / w).floor()) {
        throw new StateError('overflow');
      }

      i += digit * w;
      final int t = k <= bias ? _T_MIN : (k >= bias + _T_MAX ? _T_MAX : k - bias);

      if (digit < t) {
        break;
      }

      final int baseMinusT = _BASE - t;
      if (w > (_MAX_32_BIT_INT / baseMinusT).floor()) {
        throw new StateError('overflow');
      }

      w *= baseMinusT;

    }

    final int out = buffer.length + 1;
    bias = _adapt(i - oldi, out, oldi == 0);

    // `i` was supposed to wrap around from `out` to `0`,
    // incrementing `n` each time, so we'll fix that now:
    if ((i / out).floor() > _MAX_32_BIT_INT  - n) {
      throw new StateError('overflow');
    }

    n += (i / out).floor();
    i %= out;

    // Insert `n` at position `i` of the output
    buffer.insert(i++, n);
  }

  return new String.fromCharCodes(buffer);
}
