part of net;

const _UriDecoder _URI_DECODER = const _UriDecoder();

final Codec<String, String> querySafeUtf8UriCodec = utf8UriCodec(_QUERY_SAFE_CHARS.matches);

Codec<String, String> utf8UriCodec(bool safeCodepoints(int codePoint)) =>
    uriCodec(safeCodepoints, UTF8);

Codec<String, String> uriCodec(bool safeCodepoints(int codePoint), final Encoding encoding) =>
    new _UriCodec(safeCodepoints, encoding);

class _UriCodec extends Codec<String, String> {
  final Converter<String, String> decoder;
  final Converter<String, String> encoder;

  _UriCodec(final Predicate safeCodepoints, final Encoding encoding) :
    decoder = _URI_DECODER.fuse(encoding.decoder),
    encoder = new _UriEncoder(safeCodepoints, encoding);
}

class _UriEncoder extends Converter<String, String> {
  final Predicate _isSafeCodepoint;
  final Encoding _encoding;

  const _UriEncoder(this._isSafeCodepoint, this._encoding);

  String _percentEncode(final int input) {
    final String str = new String.fromCharCode(input);
    final List<int> bytes = _encoding.encoder.convert(str);

    final StringBuffer encoded = new StringBuffer();
    bytes.forEach((final int byte) {
      final String hex = byte.toRadixString(16);
      encoded.write("%");
      if (hex.length == 1) {
        encoded.write("0");
      }
      encoded.write(hex.toUpperCase());
    });
    return encoded.toString();
  }

  String convert(final String input){
    checkNotNull(input);
    final StringBuffer encoded = new StringBuffer();

    input.runes.forEach((final int codePoint) =>
      encoded.write(_isSafeCodepoint(codePoint) ?
          new String.fromCharCode(codePoint) :
            _percentEncode(codePoint)));

    return encoded.toString();
  }
}

class _UriDecoder extends Converter<String, List<int>> {
  static const _PERCENT = 37;

  const _UriDecoder();

  List<int> convert(final String input){
    checkNotNull(input);

    final List<int> codeUnits = input.codeUnits;
    final MutableSequence result = new MutableFixedSizeSequence(codeUnits.length);

    for (int i = 0; i < codeUnits.length;) {
      final int c = codeUnits[i];

      if (c == _PERCENT) {
        checkArgument(codeUnits.length > (i + 2));
        final String hexValue = new String.fromCharCodes(codeUnits.sublist(i+1, i+3));
        final int value = int.parse(hexValue, radix : 16);
        result.add(value);
        i += 3;
      } else {
        result.add(c);
        i++;
      }
    }
    return result.asList();
  }
}

class _PercentEncodedStringParser extends ParserBase<String> {
  static const _PERCENT = 37;

  final Predicate safeCodePoints;

  const _PercentEncodedStringParser(this.safeCodePoints);

  bool parsePercentEncoded(final IterableString str, final CodePointIterator itr) {
    final int startIndex = itr.index;
    int endIndex = startIndex;

    while (itr.moveNext()) {
      if (itr.current != _PERCENT) {
        itr.index = endIndex - 1;
        break;
      }

      if (!itr.moveNext()) {
        return false;
      }

      if (!HEXDIG.matches(itr.current)) {
        return false;
      }

      if (!itr.moveNext()) {
        return false;
      }

      if (!HEXDIG.matches(itr.current)) {
        return false;
      }

      endIndex = itr.index + 1;
    }

    final String result = str.substring(startIndex, endIndex).toString();

    try {
      _URI_DECODER.convert(result);
    } catch(e) {
      return false;
    }

    return true;
  }

  ParseResult<String> parseFrom(final IterableString str) {
    final CodePointIterator itr = str.iterator;

    while (itr.moveNext()) {
      if (itr.current == _PERCENT) {
        itr.index = itr.index - 1;
        if (!parsePercentEncoded(str, itr)) {
          return new ParseResult.failure(str);
        }
      } else if (!safeCodePoints(itr.current)) {
        break;
      }
    }

    final String retval = str.substring(0, itr.index).toString();
    if (retval.isEmpty) {
      return new ParseResult.failure(str);
    }

    return new ParseResult.success(retval, str.substring(itr.index));
  }
}