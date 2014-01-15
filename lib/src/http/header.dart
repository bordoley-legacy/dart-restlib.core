part of restlib.core.http;

class Header {  
  static const Header ACCEPT = const Header._internal("Accept");   
  static const Header ACCEPT_CHARSET = const Header._internal("Accept-Charset");
  static const Header ACCEPT_ENCODING = const Header._internal("Accept-Encoding");
  static const Header ACCEPT_LANGUAGE = const Header._internal("Accept-Language"); 
  static const Header ACCEPT_RANGES = const Header._internal("Accept-Ranges");
  static const Header AGE = const Header._internal("Age");
  static const Header ALLOW = const Header._internal("Allow");
  static const Header AUTHORIZATION = const Header._internal("Authorization");
  static const Header CACHE_CONTROL = const Header._internal("Cache-Control");
  static const Header CONNECTION = const Header._internal("Connection"); 
  static const Header CONTENT_ENCODING = const Header._internal("Content-Encoding");
  static const Header CONTENT_LANGUAGE = const Header._internal("Content-Language");
  static const Header CONTENT_LENGTH = const Header._internal("Content-Length");
  static const Header CONTENT_LOCATION = const Header._internal("Content-Location");
  static const Header CONTENT_MD5 = const Header._internal("Content-MD5");
  static const Header CONTENT_RANGE = const Header._internal("Content-Range");
  static const Header CONTENT_TYPE = const Header._internal("Content-Type");
  static const Header DATE = const Header._internal("Date");
  static const Header ENTITY_TAG = const Header._internal("ETag");
  static const Header EXPECT = const Header._internal("Expect");
  static const Header EXPIRES = const Header._internal("Expires");
  static const Header FROM = const Header._internal("From");
  static const Header HOST = const Header._internal("Host");
  static const Header IF_MATCH = const Header._internal("If-Match");
  static const Header IF_MODIFIED_SINCE = const Header._internal("If-Modified-Since");
  static const Header IF_NONE_MATCH = const Header._internal("If-None-Match");
  static const Header IF_RANGE = const Header._internal("If-Range");
  static const Header IF_UNMODIFIED_SINCE = const Header._internal("If-Unmodified-Since");
  static const Header LAST_MODIFIED = const Header._internal("Last-Modified");
  static const Header LOCATION = const Header._internal("Location");
  static const Header MAX_FORWARDS = const Header._internal("Max-Forwards");
  static const Header PRAGMA = const Header._internal("Pragma");
  static const Header PROXY_AUTHENTICATE = const Header._internal("Proxy-Authenticate");
  static const Header PROXY_AUTHORIZATION = const Header._internal("Proxy-Authorization");
  static const Header RANGE = const Header._internal("Range");
  static const Header REFERER = const Header._internal("Referer");
  static const Header RETRY_AFTER = const Header._internal("Retry-After");
  static const Header SERVER = const Header._internal("Server");
  static const Header TE = const Header._internal("TE");
  static const Header TRAILER = const Header._internal("Trailer");
  static const Header TRANSFER_ENCODING = const Header._internal("Transfer-Encoding");
  static const Header UPGRADE = const Header._internal("Upgrade");
  static const Header USER_AGENT = const Header._internal("User-Agent");
  static const Header VARY = const Header._internal("Vary");
  static const Header VIA = const Header._internal("Via");  
  static const Header WARNING = const Header._internal("Warning");
  static const Header WWW_AUTHENTICATE = const Header._internal("WWW-Authenticate");
  
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
  
  final String header;
  
  const Header._internal(this.header);
  
  String write(var value) {
    String headerValue = asHeaderValue(value);
    return !headerValue.isEmpty ? "${header}: ${headerValue}\r\n" : "";
  }
  
  String toString() {
    return header;
  }
}
