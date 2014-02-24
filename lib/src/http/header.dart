part of restlib.core.http;

String _headerLine(final Header header, final value) {
  final String headerValue = asHeaderValue(value);
  return headerValue.isNotEmpty ? "$header: ${headerValue}\r\n" : "";
}

String asHeaderValue(final value) {
  if (value is String) {
    return value;
  }

  try {
    return value.asHeaderString();
  } on NoSuchMethodError {
    // ignore no such method error.
  }

  if (value is Option) {
    return value.map(asHeaderValue).orElse("");
  } else if (value is Iterable) {
    return value.isEmpty ? "" : value.join(", ");
  } else if (value is DateTime) {
    return toHttpDate(value);
  } else {
    return value.toString();
  }
}

final FiniteSet<Header> _standardHeaders =
    EMPTY_SET.addAll(
        [ACCEPT, ACCEPT_CHARSET, ACCEPT_ENCODING, ACCEPT_LANGUAGE, ACCEPT_RANGES,
         AGE, ALLOW, AUTHORIZATION, CACHE_CONTROL, CONNECTION, CONTENT_ENCODING,
         CONTENT_LENGTH, CONTENT_LOCATION, CONTENT_MD5, CONTENT_RANGE, CONTENT_TYPE,
         COOKIE, DATE, ENTITY_TAG, EXPECT, EXPIRES, FROM, HOST, IF_MATCH, IF_MODIFIED_SINCE,
         IF_NONE_MATCH, IF_RANGE, IF_UNMODIFIED_SINCE, LAST_MODIFIED, LOCATION,
         MAX_FORWARDS, PRAGMA, PROXY_AUTHENTICATE, PROXY_AUTHORIZATION, RANGE, REFERER,
         RETRY_AFTER, SERVER, SET_COOKIE, TE, TRAILER, TRANSFER_ENCODING, UPGRADE, USER_AGENT,
         VARY, VIA, WARNING, WWW_AUTHENTICATE]);

abstract class Header {
  static final Parser<Header> parser =
      TOKEN.map((final String token) =>
          // FIXME: For standard headers return the const instance ideally
          new HeaderImpl(token.toLowerCase(), token));

  factory Header(final String header) =>
      parser.parseValue(header);
}

