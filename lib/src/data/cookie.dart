part of restlib.core.data;
// http://tools.ietf.org/html/rfc6265

final Parser<SetCookie> SET_COOKIE =
  (COOKIE_PAIR + _SET_COOKIE_ATTRIBUTES).map((final Iterable e) =>
      new SetCookie._internal(e.elementAt(0),Persistent.EMPTY_SET.addAll(e.elementAt(1))));
  
final Parser<Iterable<CookieAttribute>> _SET_COOKIE_ATTRIBUTES = 
  (SEMICOLON + _COOKIE_AV.sepBy(SEMICOLON)).map((final Iterable e) => 
      e.elementAt(1)).orElse(EMPTY_LIST);

final Parser<CookieAttribute> _COOKIE_AV = 
  _EXPIRES_AV | _MAX_AGE_AV | _DOMAIN_AV | _PATH_AV | _SECURE_AV | _HTTP_ONLY_AV | _EXTENSION_AV;

final Parser<CookieAttribute> _EXPIRES_AV =
  (string("Expires=") + HTTP_DATE_TIME).map((final Iterable e) =>
      new CookieExpiresAttribute._internal(e.elementAt(1)));

final Parser<CookieAttribute> _MAX_AGE_AV =
  (string("Max-Age=") + INTEGER).map((final Iterable e) =>
      new CookieMaxAgeAttribute._internal(e.elementAt(1)));

final Parser<CookieAttribute> _DOMAIN_AV =
  (string("Domain=") + DOMAIN_NAME).map((final Iterable e) => 
      new CookieDomainAttribute._internal(e.elementAt(1)));

final Parser<CookieAttribute> _PATH_AV =
  (string("Path=") + PATH).map((final Iterable e) =>
      new CookiePathAttribute._internal(e.elementAt(1)));

final Parser<CookieAttribute> _HTTP_ONLY_AV = 
  string(CookieAttribute.HTTP_ONLY.toString()).map((_) => 
      CookieAttribute.HTTP_ONLY); 

final Parser<CookieAttribute> _SECURE_AV = 
  string(CookieAttribute.SECURE.toString()).map((_) => 
      CookieAttribute.SECURE); 

final Parser<CookieAttribute> _EXTENSION_AV =
  (CHAR & CTL.negate() & SEMICOLON.negate()).many().map((final IterableString ext) =>
      new CookieExtensionAttribute._internal(ext.toString()));

final Parser<Cookie> COOKIE_PAIR = 
  (TOKEN + EQUALS + _COOKIE_VALUE)
    .map((final Iterable e) =>
        new Cookie._internal(e.elementAt(0), e.elementAt(2)));

final Parser<String> _COOKIE_VALUE = (_COOKIE_OCTET.many() | _QUOTED_COOKIE_OCTET).map(objectToString);

final Parser<IterableString> _QUOTED_COOKIE_OCTET = 
  (DQUOTE + _COOKIE_OCTET.many() + DQUOTE).map((final Iterable e) =>
      e.elementAt(1));

final RuneMatcher _COOKIE_OCTET = 
  isChar("\u0021") | inRange("\u0023", "\u002B") | 
  inRange("\u002D", "\u003A") | inRange("\u003C", "\u005B") | inRange("\u005D", "\u007E");

final RuneMatcher _EXTENSION_VALUE = CHAR & CTL.negate() & SEMICOLON.negate();

// cookie-pair
class Cookie extends Pair<String, String> {
  
  const Cookie._internal(final String fst, final String snd) : super(fst,snd);
  
  int get hashCode =>
      super.hashCode;
  
  bool operator==(other) =>
      super == other;
}

class SetCookie {
  final Cookie cookie;
  final ImmutableSet<CookieAttribute> attributes;
  
  SetCookie._internal(this.cookie, this.attributes);
  
  String toString() {
    final StringBuffer buffer = new StringBuffer();
    buffer.write(cookie);
    attributes.forEach((final CookieAttribute attr) =>
        buffer..write("; ")..write(attr));
    return buffer.toString();
  }
      
}

// cookie-av
abstract class CookieAttribute {
  static const CookieAttribute HTTP_ONLY = const _CookieHttpOnlyAttribute._internal();
  static const CookieAttribute SECURE = const _CookieSecureAttribute._internal();
  
  factory CookieAttribute.expiresOn(final DateTime date) =>
      new CookieExpiresAttribute._internal(checkNotNull(date));
  
  factory CookieAttribute.extension(final String value) {
    checkNotNull(value);
    checkArgument(!value.startsWith("Expires=") || 
        !value.startsWith("Max-Age=") ||
        !value.startsWith("Domain=") ||
        !value.startsWith("Path=") ||
        value != "Secure" ||
        value !="HttpOnly");
    
    checkArgument(_EXTENSION_VALUE.matchesAllOf(value));
    
    return new CookieExtensionAttribute._internal(value);
  }
  
  factory CookieAttribute.maxAge(final int maxAge) =>
      new CookieMaxAgeAttribute._internal(checkNotNull(maxAge));
  
  factory CookieAttribute.domain(final DomainName domain) =>
      new CookieDomainAttribute._internal(checkNotNull(domain));
  
  factory CookieAttribute.path(final Path path) =>
      new CookiePathAttribute._internal(checkNotNull(path));
  
}

class CookieExpiresAttribute implements CookieAttribute {
  final DateTime expiresOn;
  
  const CookieExpiresAttribute._internal(this.expiresOn);
  
  String toString() =>
      "Expires=${toHttpDate(expiresOn)}";
}

class CookieMaxAgeAttribute implements CookieAttribute {
  final int maxAge;
  
  const CookieMaxAgeAttribute._internal(this.maxAge);
  
  String toString() =>
      "Max-Age=$maxAge";
}

class CookieDomainAttribute implements CookieAttribute {
  final DomainName domainName;
  
  const CookieDomainAttribute._internal(this.domainName);
  
  String toString() =>
      "Domain=$domainName";
}

class CookiePathAttribute implements CookieAttribute {
  final Path path;
  
  CookiePathAttribute._internal(this.path);
  
  String toString() =>
      "Path=$path";
}

class _CookieSecureAttribute implements CookieAttribute {
  const _CookieSecureAttribute._internal();
  
  String toString() =>
      "Secure";
}

class _CookieHttpOnlyAttribute implements CookieAttribute {
  const _CookieHttpOnlyAttribute._internal();
  
  String toString() =>
      "HttpOnly";
}

class CookieExtensionAttribute implements CookieAttribute {
  final String value;
  CookieExtensionAttribute._internal(this.value);
  
  int get hashCode =>
      super.hashCode;
  
  bool operator==(other) =>
      super == other;
  
  String toString() =>
      "$value";
}