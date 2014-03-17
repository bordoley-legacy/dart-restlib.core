part of http.internal;

String encodeQuotedString(final String val) {
  final StringBuffer retval = new StringBuffer();

  void write(final int codepoint) =>
      retval.write(new String.fromCharCode(codepoint));

  write(_DQUOTE_CHAR);

  new IterableString(val).forEach((final int codepoint) {
    if(QD_TEXT.matches(codepoint)) {
      write(codepoint);
    } else if (codepoint == _DQUOTE_CHAR || codepoint == _ESCAPE_CHAR) {
      write(_ESCAPE_CHAR);
      write(codepoint);
    } else {
      throw new ArgumentError("val includes the character $codepoint which cannot be included in a quoted string");
    }
  });

  write(_DQUOTE_CHAR);
  return retval.toString();
}


String encodeWord(final String val) =>
    TOKEN.parse(val).left.orCompute(() =>
        encodeQuotedString(val));
