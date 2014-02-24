part of restlib.core.data;

abstract class CookieMultimap implements ImmutableSetMultimap<String, String> {
  static final CookieMultimap EMPTY = new CookieMultimapImpl.empty();

  CookieMultimap put(final String key, final String value);
  CookieMultimap putAll(final Iterable<Pair<String, String>> other);
  CookieMultimap putAllFromMap(final Map<String, String> map);
  CookieMultimap putPair(final Pair<String, String> pair);
  CookieMultimap removeAt(final String key);
}

// cookie-pair
abstract class Cookie implements Pair<String, String> {
  static final Parser<Cookie> parser = COOKIE_PAIR;
}

abstract class SetCookie {
  static final Parser<SetCookie> parser = SET_COOKIE;

  Cookie get cookie;
  ImmutableSet<CookieAttribute> get attributes;
}

// cookie-av
abstract class CookieAttribute {
  static const CookieAttribute HTTP_ONLY = const CookieExtensionAttributeImpl("HttpOnly");
  static const CookieAttribute SECURE = const CookieExtensionAttributeImpl("Secure");

  factory CookieAttribute.expiresOn(final DateTime date) =>
      new CookieExpiresAttributeImpl(checkNotNull(date));

  factory CookieAttribute.extension(final String value) {
    checkNotNull(value);
    checkArgument(!value.startsWith("Expires=") ||
        !value.startsWith("Max-Age=") ||
        !value.startsWith("Domain=") ||
        !value.startsWith("Path=") ||
        value != "Secure" ||
        value !="HttpOnly");

    checkArgument(EXTENSION_VALUE.matchesAllOf(value));

    return new CookieExtensionAttributeImpl(value);
  }

  factory CookieAttribute.maxAge(final int maxAge) =>
      new CookieMaxAgeAttributeImpl(checkNotNull(maxAge));

  factory CookieAttribute.domain(final DomainName domain) =>
      new CookieDomainAttributeImpl(checkNotNull(domain));

  factory CookieAttribute.path(final Path path) =>
      new CookiePathAttributeImpl(checkNotNull(path));
}

abstract class CookieExpiresAttribute implements CookieAttribute {
  DateTime get expiresOn;
}

abstract class CookieMaxAgeAttribute implements CookieAttribute {
  int get maxAge;
}

abstract class CookieDomainAttribute implements CookieAttribute {
  DomainName get domainName;
}

abstract class CookiePathAttribute implements CookieAttribute {
  Path get path;
}

abstract class CookieExtensionAttribute implements CookieAttribute {
  String get value;
}
