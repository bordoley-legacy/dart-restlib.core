part of restlib.core.http;

final Parser<Header> HEADER = 
  TOKEN.map((final String token) =>
      // FIXME: For standard headers return the const instance ideally
      new Header._internal(token.toLowerCase(), token));

class Header {  
  static FiniteSet<Header> _standard = 
      Persistent.EMPTY_SET.addAll(
          [ACCEPT, ACCEPT_CHARSET, ACCEPT_ENCODING, ACCEPT_LANGUAGE, ACCEPT_RANGES,
           AGE, ALLOW, AUTHORIZATION, CACHE_CONTROL, CONNECTION, CONTENT_ENCODING,
           CONTENT_LENGTH, CONTENT_LOCATION, CONTENT_MD5, CONTENT_RANGE, CONTENT_TYPE,
           DATE, ENTITY_TAG, EXPECT, EXPIRES, FROM, HOST, IF_MATCH, IF_MODIFIED_SINCE,
           IF_NONE_MATCH, IF_RANGE, IF_UNMODIFIED_SINCE, LAST_MODIFIED, LOCATION,
           MAX_FORWARDS, PRAGMA, PROXY_AUTHENTICATE, PROXY_AUTHORIZATION, RANGE,
           RETRY_AFTER, SERVER, TE, TRAILER, TRANSFER_ENCODING, UPGRADE, USER_AGENT,
           VARY, VIA, WARNING, WWW_AUTHENTICATE]);
  
  static const Header ACCEPT = const Header._internal("accept", "Accept");   
  static const Header ACCEPT_CHARSET = const Header._internal("accept-charset", "Accept-Charset");
  static const Header ACCEPT_ENCODING = const Header._internal("accept-encoding", "Accept-Encoding");
  static const Header ACCEPT_LANGUAGE = const Header._internal("accept-language", "Accept-Language"); 
  static const Header ACCEPT_RANGES = const Header._internal("accept-ranges", "Accept-Ranges");
  static const Header AGE = const Header._internal("age", "Age");
  static const Header ALLOW = const Header._internal("allow", "Allow");
  static const Header AUTHORIZATION = const Header._internal("authorization", "Authorization");
  static const Header CACHE_CONTROL = const Header._internal("cache-control", "Cache-Control");
  static const Header CONNECTION = const Header._internal("connection", "Connection"); 
  static const Header CONTENT_ENCODING = const Header._internal("content-encoding", "Content-Encoding");
  static const Header CONTENT_LANGUAGE = const Header._internal("content-language", "Content-Language");
  static const Header CONTENT_LENGTH = const Header._internal("content-length", "Content-Length");
  static const Header CONTENT_LOCATION = const Header._internal("content-location","Content-Location");
  static const Header CONTENT_MD5 = const Header._internal("content-md5", "Content-MD5");
  static const Header CONTENT_RANGE = const Header._internal("content-range", "Content-Range");
  static const Header CONTENT_TYPE = const Header._internal("content-type", "Content-Type");
  static const Header DATE = const Header._internal("date", "Date");
  static const Header ENTITY_TAG = const Header._internal("etag", "ETag");
  static const Header EXPECT = const Header._internal("expect", "Expect");
  static const Header EXPIRES = const Header._internal("expires", "Expires");
  static const Header FROM = const Header._internal("from", "From");
  static const Header HOST = const Header._internal("host", "Host");
  static const Header IF_MATCH = const Header._internal("if-match", "If-Match");
  static const Header IF_MODIFIED_SINCE = const Header._internal("if-modified-since", "If-Modified-Since");
  static const Header IF_NONE_MATCH = const Header._internal("if-none-match", "If-None-Match");
  static const Header IF_RANGE = const Header._internal("if-range", "If-Range");
  static const Header IF_UNMODIFIED_SINCE = const Header._internal("if-unmodified-since", "If-Unmodified-Since");
  static const Header LAST_MODIFIED = const Header._internal("last-modified", "Last-Modified");
  static const Header LOCATION = const Header._internal("location", "Location");
  static const Header MAX_FORWARDS = const Header._internal("max-forwards", "Max-Forwards");
  static const Header PRAGMA = const Header._internal("pragma", "Pragma");
  static const Header PROXY_AUTHENTICATE = const Header._internal("proxy-authenticat", "Proxy-Authenticate");
  static const Header PROXY_AUTHORIZATION = const Header._internal("proxy-authorization", "Proxy-Authorization");
  static const Header RANGE = const Header._internal("range", "Range");
  static const Header REFERER = const Header._internal("referer","Referer");
  static const Header RETRY_AFTER = const Header._internal("retry-after", "Retry-After");
  static const Header SERVER = const Header._internal("server", "Server");
  static const Header TE = const Header._internal("te", "TE");
  static const Header TRAILER = const Header._internal("trailer", "Trailer");
  static const Header TRANSFER_ENCODING = const Header._internal("transfer-encoding", "Transfer-Encoding");
  static const Header UPGRADE = const Header._internal("upgrade", "Upgrade");
  static const Header USER_AGENT = const Header._internal("user-agent", "User-Agent");
  static const Header VARY = const Header._internal("vary", "Vary");
  static const Header VIA = const Header._internal("via", "Via");  
  static const Header WARNING = const Header._internal("warning", "Warning");
  static const Header WWW_AUTHENTICATE = const Header._internal("www-authenticate", "WWW-Authenticate");
  
  static String asHeaderValue(final value) {
    if (value is Option) {
      return value
        .map((final value) =>
            asHeaderValue(value))
        .orElse("");
    } else if (value is Iterable) {
      return (value.isEmpty) ? "" : value.join(", ");
    } else if (value is DateTime) {
      return toHttpDate(value);
    } else {
      return value.toString();
    } 
  }
  
  final String _header;
  final String _display;
  
  const Header._internal(this._header, this._display);
  
  int get hashCode =>
      _header.hashCode;
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is Header) {
      return this._header == other._header;
    } else {
      return false;
    }
  }
  
  String write(var value) {
    String headerValue = asHeaderValue(value);
    return !headerValue.isEmpty ? "${_display}: ${headerValue}\r\n" : "";
  }
  
  String toString() {
    return _display;
  }
}
