part of http.internal;

const int _DQUOTE_CHAR = 34;
const int _ESCAPE_CHAR = 92;

class _QuotedStringParser extends ParserBase<String> {
  const _QuotedStringParser();

  ParseResult<String> parseFrom(final IterableString str) {
    int endIndex = 0;
    final CodePointIterator itr = str.iterator;

    // Only use a buffer if there are escaped chars in the string.
    StringBuffer buffer = null;

    if (!itr.moveNext() || itr.current != _DQUOTE_CHAR) {
      return null;
    }

    while(itr.moveNext()) {
      int c = itr.current;

      if (QD_TEXT.matches(c)) {
        if (buffer != null) {
          buffer.writeCharCode(c);
        } else {
          endIndex++;
        }
      } else if (c == _ESCAPE_CHAR) {
        // Create a new buffer if needed and copy all of the already parsed string
        // into the buffer.
        if (buffer == null) {
          buffer = new StringBuffer(str.substring(0, endIndex).toString());
        }

        if (!itr.moveNext()) {
          return new ParseResult.eof(str);
        }

        if (QUOTED_PAIR_CHAR.matches(itr.current)) {
          buffer.writeCharCode(itr.current);
        } else {
          return new ParseResult.failure(str);
        }
      } else if (c == _DQUOTE_CHAR) {
        if (buffer != null) {
          endIndex++;
          return new ParseResult.success(buffer.toString(), str.substring(endIndex + 1));
        } else {
          endIndex++;
          return new ParseResult.success(str.substring(2, endIndex + 1).toString(), str.substring(endIndex + 1));
        }
      } else {
        return new ParseResult.failure(str);
      }
    }

    return new ParseResult.eof(str);
  }

  String toString() => "QuotedStringParser";
}