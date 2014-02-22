part of restlib.core.data;

abstract class CacheDirective implements Pair<String,String> {
  static const String _MAX_AGE_NAME = "max-age";
  static const String _MAX_STALE_NAME = "max-stale";
  static const String _MIN_FRESH_NAME = "min-fresh";
  static const String _MUST_REVALIDATE_NAME = "must-revalidate";
  static const String _NO_CACHE_NAME = "no-cache";
  static const String _NO_STORE_NAME = "no-store";
  static const String _NO_TRANSFORM_NAME = "no-transform";
  static const String _ONLY_IF_CACHED_NAME = "only-if-cached";
  static const String _PRIVATE_NAME = "private";
  static const String _PROXY_REVALIDATE_NAME = "proxy-revalidate";
  static const String _PUBLIC_NAME = "public";
  static const String _SHARED_MAX_AGE_NAME = "s-maxage";

  static const CacheDirective MAX_STALE = const CacheDirectiveImpl(_MAX_STALE_NAME, "");
  static const CacheDirective MUST_REVALIDATE = const CacheDirectiveImpl(_MUST_REVALIDATE_NAME, "");
  static const CacheDirective NO_CACHE = const CacheDirectiveImpl(_NO_CACHE_NAME, "");
  static const CacheDirective NO_STORE = const CacheDirectiveImpl(_NO_STORE_NAME, "");
  static const CacheDirective NO_TRANSFORM = const CacheDirectiveImpl(_NO_TRANSFORM_NAME, "");
  static const CacheDirective ONLY_IF_CACHED = const CacheDirectiveImpl(_ONLY_IF_CACHED_NAME, "");
  static const CacheDirective PRIVATE = const CacheDirectiveImpl(_PRIVATE_NAME, "");
  static const CacheDirective PROXY_REVALIDATE = const CacheDirectiveImpl(_PROXY_REVALIDATE_NAME, "");
  static const CacheDirective PUBLIC = const CacheDirectiveImpl(_PUBLIC_NAME, "");

  static final Parser<CacheDirective> parser = CACHE_DIRECTIVE;

  factory CacheDirective(String key, [String value]) {
    checkArgument(TCHAR.matchesAllOf(key));
    checkArgument(QUOTABLE.matchesAllOf(value));
    key = key.toLowerCase();
    value = firstNotNull(value, "");

    return new CacheDirectiveImpl(key, value);
  }

  factory CacheDirective.createWithDigitValue(String key, int value) {
    checkArgument(TCHAR.matchesAllOf(key));
    checkArgument(value >= 0);
    checkArgument(value <= 2147483648);

    return new CacheDirectiveImpl(key.toLowerCase(), value.toString());
  }

  factory CacheDirective.maxAge(final int seconds) {
    checkArgument(seconds >= 0);
    return new CacheDirectiveImpl(_MAX_AGE_NAME, seconds.toString());
  }

  factory CacheDirective.maxStale(final int seconds) {
    checkArgument(seconds >= 0);
    return new CacheDirectiveImpl(_MAX_STALE_NAME, seconds.toString());
  }

  factory CacheDirective.minFresh(final int seconds) {
    checkArgument(seconds >= 0);
    return new CacheDirectiveImpl(_MIN_FRESH_NAME, seconds.toString());
  }

  factory CacheDirective.noCache(final Iterable<Header> fields) {
    if (fields.isEmpty) {
      return CacheDirective.NO_CACHE;
    }
    return new CacheDirectiveImpl(_NO_CACHE_NAME, fields.join(", "));
  }

  factory CacheDirective.privateInfo(final Iterable<Header> fields) {
    if (fields.isEmpty) {
      return CacheDirective.PRIVATE;
    }
    return new CacheDirectiveImpl(_PRIVATE_NAME, fields.join(", "));
  }

  factory CacheDirective.sharedMaxAge(final int seconds) {
    checkArgument(seconds > 0);
    return new CacheDirectiveImpl(_SHARED_MAX_AGE_NAME, seconds.toString());
  }
}