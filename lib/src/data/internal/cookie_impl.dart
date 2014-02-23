part of restlib.core.data.internal;

// http://tools.ietf.org/html/rfc6265

final Parser<SetCookie> SET_COOKIE =
  (COOKIE_PAIR + _SET_COOKIE_ATTRIBUTES).map((final Iterable e) =>
      new _SetCookie._internal(e.elementAt(0), EMPTY_SET.addAll(e.elementAt(1))));

final Parser<Iterable<CookieAttribute>> _SET_COOKIE_ATTRIBUTES =
  (SEMICOLON + _COOKIE_AV.sepBy(SEMICOLON)).map((final Iterable e) =>
      e.elementAt(1)).orElse(EMPTY_LIST);

final Parser<CookieAttribute> _COOKIE_AV =
  _EXPIRES_AV | _MAX_AGE_AV | _DOMAIN_AV | _PATH_AV | _SECURE_AV | _HTTP_ONLY_AV | _EXTENSION_AV;

final Parser<CookieAttribute> _EXPIRES_AV =
  (string("Expires=") + HTTP_DATE_TIME).map((final Iterable e) =>
      new CookieExpiresAttributeImpl(e.elementAt(1)));

final Parser<CookieAttribute> _MAX_AGE_AV =
  (string("Max-Age=") + INTEGER).map((final Iterable e) =>
      new CookieMaxAgeAttributeImpl(e.elementAt(1)));

final Parser<CookieAttribute> _DOMAIN_AV =
  (string("Domain=") + DomainName.parser).map((final Iterable e) =>
      new CookieDomainAttributeImpl(e.elementAt(1)));

final Parser<CookieAttribute> _PATH_AV =
  (string("Path=") + Path.parser).map((final Iterable e) =>
      new CookiePathAttributeImpl(e.elementAt(1)));

final Parser<CookieAttribute> _HTTP_ONLY_AV =
  string(CookieAttribute.HTTP_ONLY.toString()).map((_) =>
      CookieAttribute.HTTP_ONLY);

final Parser<CookieAttribute> _SECURE_AV =
  string(CookieAttribute.SECURE.toString()).map((_) =>
      CookieAttribute.SECURE);

final Parser<CookieAttribute> _EXTENSION_AV =
  (CHAR & CTL.negate() & SEMICOLON.negate()).many().map((final IterableString ext) =>
      new CookieExtensionAttributeImpl(ext.toString()));

final Parser<Cookie> COOKIE_PAIR =
  (TOKEN + EQUALS + _COOKIE_VALUE)
    .map((final Iterable e) =>
        new CookieImpl._internal(e.elementAt(0), e.elementAt(2)));

final Parser<String> _COOKIE_VALUE = (_COOKIE_OCTET.many() | _QUOTED_COOKIE_OCTET).map(objectToString);

final Parser<IterableString> _QUOTED_COOKIE_OCTET =
  (DQUOTE + _COOKIE_OCTET.many() + DQUOTE).map((final Iterable e) =>
      e.elementAt(1));

final RuneMatcher _COOKIE_OCTET =
  isChar("\u0021") | inRange("\u0023", "\u002B") |
  inRange("\u002D", "\u003A") | inRange("\u003C", "\u005B") | inRange("\u005D", "\u007E");

final RuneMatcher EXTENSION_VALUE = CHAR & CTL.negate() & SEMICOLON.negate();


class CookieMultimapImpl
    extends Object
    with ForwardingMultimap<String, String, FiniteSet<String>>,
      ForwardingAssociative<String, String>,
      IterableMixin<Pair<String, String>>
    implements CookieMultimap {

  final ImmutableSetMultimap<String, String> delegate;

  // FIXME: Should be const: https://code.google.com/p/dart/issues/detail?id=9745
  CookieMultimapImpl(this.delegate);

  // FIXME: Should be const: https://code.google.com/p/dart/issues/detail?id=9745
  CookieMultimapImpl.empty() :
    this.delegate = EMPTY_SET_MULTIMAP;

  int get hashCode =>
      delegate.hashCode;

  Iterator<Cookie> get iterator =>
      delegate.map((final Pair<String, String> pair) =>
          new CookieImpl._wrap(pair)).iterator;

  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    }

    return delegate == other;
  }

  CookieMultimap put(final String key, final String value) =>
      new CookieMultimapImpl(delegate.put(key, value));

  CookieMultimap putAll(final Iterable<Pair<String, String>> other) =>
      other.isEmpty ? this : new CookieMultimapImpl(delegate.putAll(other));

  CookieMultimap putAllFromMap(final Map<String, String> map) =>
      map.isEmpty ? this : new CookieMultimapImpl(delegate.putAllFromMap(map));

  CookieMultimap putPair(final Pair<String, String> pair) =>
      new CookieMultimapImpl(delegate.putPair(pair));

  CookieMultimap removeAt(final String key) =>
      delegate.dictionary[key]
        .map((_) => new CookieMultimapImpl(delegate.removeAt(key)))
        .orElse(this);

  String toString() =>
      join("; ");
}

class CookieImpl implements Cookie {
  final Pair<String, String> _delegate;

  CookieImpl._internal(final String fst, final String snd) :
    _delegate = new Pair(fst, snd);

  CookieImpl._wrap(this._delegate);

  String get fst =>
      _delegate.fst;

  String get snd =>
      _delegate.snd;

  int get hashCode =>
      _delegate.hashCode;

  bool operator==(other) =>
      _delegate == other;

  String toString() =>
      "$fst=$snd";
}

class _SetCookie implements SetCookie{
  final Cookie cookie;
  final ImmutableSet<CookieAttribute> attributes;

  _SetCookie._internal(this.cookie, this.attributes);

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

class CookieExpiresAttributeImpl implements CookieExpiresAttribute {
  final DateTime expiresOn;

  const CookieExpiresAttributeImpl(this.expiresOn);

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

class CookieMaxAgeAttributeImpl implements CookieMaxAgeAttribute {
  final int maxAge;

  const CookieMaxAgeAttributeImpl(this.maxAge);

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

class CookieDomainAttributeImpl implements CookieDomainAttribute {
  final DomainName domainName;

  const CookieDomainAttributeImpl(this.domainName);

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

class CookiePathAttributeImpl implements CookiePathAttribute {
  final Path path;

  CookiePathAttributeImpl(this.path);

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

class CookieExtensionAttributeImpl implements CookieExtensionAttribute {
  final String value;

  const CookieExtensionAttributeImpl(this.value);

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