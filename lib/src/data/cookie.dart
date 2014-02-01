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

abstract class CookieMultimap implements ImmutableSetMultimap<String, String> {
  static final  CookieMultimap EMPTY = new _CookieMultimap.empty();
  
  CookieMultimap put(final String key, final String value);
  CookieMultimap putAll(final Iterable<Pair<String, String>> other);
  CookieMultimap putAllFromMap(final Map<String, String> map);
  CookieMultimap putPair(final Pair<String, String> pair);
  CookieMultimap removeAt(final String key);
}

class _CookieMultimap 
    extends Object
    with ForwardingMultimap<String, String, FiniteSet<String>>,
      ForwardingAssociative<String, String>,
      IterableMixin<Pair<String, String>> 
    implements CookieMultimap {
 
  final ImmutableSetMultimap<String, String> delegate;
  
  // FIXME: Should be const: https://code.google.com/p/dart/issues/detail?id=9745
  _CookieMultimap(this.delegate);
  
  // FIXME: Should be const: https://code.google.com/p/dart/issues/detail?id=9745
  _CookieMultimap.empty() :
    this.delegate = Persistent.EMPTY_SET_MULTIMAP;
  
  int get hashCode =>
      delegate.hashCode;
  
  Iterator<Cookie> get iterator =>
      delegate.map((final Pair<String, String> pair) => 
          new Cookie._internal(pair.fst, pair.snd)).iterator;
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } 
    
    return delegate == other;
  }
  
  CookieMultimap put(final String key, final String value) =>
      new _CookieMultimap(delegate.put(key, value));
  
  CookieMultimap putAll(final Iterable<Pair<String, String>> other) =>
      other.isEmpty ? this : new _CookieMultimap(delegate.putAll(other));
  
  CookieMultimap putAllFromMap(final Map<String, String> map) =>
      map.isEmpty ? this : new _CookieMultimap(delegate.putAllFromMap(map));
  
  CookieMultimap putPair(final Pair<String, String> pair) =>
      new _CookieMultimap(delegate.putPair(pair));
  
  CookieMultimap removeAt(final String key) =>
      delegate.dictionary[key]
        .map((_) => new _CookieMultimap(delegate.removeAt(key)))
        .orElse(this);
  
  String toString() =>
      join("; ");
}

// cookie-pair
class Cookie extends Pair<String, String> {
  
  const Cookie._internal(final String fst, final String snd) : super(fst,snd);
  
  int get hashCode =>
      super.hashCode;
  
  bool operator==(other) =>
      super == other;
  
  String toString() =>
      "$fst=$snd";
}

class SetCookie {
  final Cookie cookie;
  final ImmutableSet<CookieAttribute> attributes;
  
  SetCookie._internal(this.cookie, this.attributes);
  
  int get hashCode =>
      computeHashCode([cookie, attributes]);
  
  bool operator==(other) {
    if (identical(this,other)) {
      return true;
    } else if (other is SetCookie) {
      return this.cookie == other.cookie &&
          this.attributes == other.attributes;
    } else {
      return false;
    }
  }
  
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
  
  int get hashCode =>
      expiresOn.hashCode;
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is CookieExpiresAttribute) {
      return this.expiresOn == other.expiresOn;
    } else {
      return false;
    }
  }
  
  String toString() =>
      "Expires=${toHttpDate(expiresOn)}";
}

class CookieMaxAgeAttribute implements CookieAttribute {
  final int maxAge;
  
  const CookieMaxAgeAttribute._internal(this.maxAge);
  
  int get hashCode =>
      maxAge;
  
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;     
    } else if (other is CookieMaxAgeAttribute) {
      return this.maxAge == other.maxAge;
    } else {
      return false;
    }
  }
  
  String toString() =>
      "Max-Age=$maxAge";
}

class CookieDomainAttribute implements CookieAttribute {
  final DomainName domainName;
  
  const CookieDomainAttribute._internal(this.domainName);
  
  int get hashCode =>
      domainName.hashCode;
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is CookieDomainAttribute) {
      return this.domainName == other.domainName;
    } else {
      return false;
    }
  }
  
  String toString() =>
      "Domain=$domainName";
}

class CookiePathAttribute implements CookieAttribute {
  final Path path;
  
  CookiePathAttribute._internal(this.path);
  
  int get hashCode =>
      path.hashCode;
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is CookiePathAttribute) {
      return this.path == other.path;
    } else {
      return false;
    }
  }
  
  String toString() =>
      "Path=$path";
}

class _CookieSecureAttribute implements CookieAttribute {
  const _CookieSecureAttribute._internal();
  
  int get hashCode =>
      toString().hashCode;
  
  bool operator==(other) =>
      identical(this, other);
  
  String toString() =>
      "Secure";
}

class _CookieHttpOnlyAttribute implements CookieAttribute {
  const _CookieHttpOnlyAttribute._internal();
  
  int get hashCode =>
      toString().hashCode;
  
  bool operator==(other) =>
      identical(this, other);
  
  String toString() =>
      "HttpOnly";
}

class CookieExtensionAttribute implements CookieAttribute {
  final String value;
  
  CookieExtensionAttribute._internal(this.value);
  
  int get hashCode =>
      value.hashCode;
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is CookieExtensionAttribute) {
      return this.value == other.value;
    } else {
      return false;
    }
  }
  
  String toString() =>
      "$value";
}