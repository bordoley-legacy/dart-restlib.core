part of restlib.core.data;

final Parser<CacheDirective> CACHE_DIRECTIVE =
  KVP.map((final KeyValuePair kvp) { 
    try {
      final int value = int.parse(kvp.snd);
      return new CacheDirective.createWithDigitValue(kvp.fst, value);
    } on FormatException{}
    
    return new CacheDirective._internal(kvp.fst.toLowerCase(), kvp.snd);
  });

class CacheDirective {
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
  
  static const CacheDirective MAX_STALE = const CacheDirective._internal(_MAX_STALE_NAME, "");
  static const CacheDirective MUST_REVALIDATE = const CacheDirective._internal(_MUST_REVALIDATE_NAME, "");
  static const CacheDirective NO_CACHE = const CacheDirective._internal(_NO_CACHE_NAME, "");
  static const CacheDirective NO_STORE = const CacheDirective._internal(_NO_STORE_NAME, "");
  static const CacheDirective NO_TRANSFORM = const CacheDirective._internal(_NO_TRANSFORM_NAME, "");
  static const CacheDirective ONLY_IF_CACHED = const CacheDirective._internal(_ONLY_IF_CACHED_NAME, "");
  static const CacheDirective PRIVATE = const CacheDirective._internal(_PRIVATE_NAME, "");
  static const CacheDirective PROXY_REVALIDATE = const CacheDirective._internal(_PROXY_REVALIDATE_NAME, "");
  static const CacheDirective PUBLIC = const CacheDirective._internal(_PUBLIC_NAME, "");
  
  factory CacheDirective(String key, [String value]) {
    checkArgument(TCHAR.matchesAllOf(key));
    checkArgument(QUOTABLE.matchesAllOf(value));
    key = key.toLowerCase();
    value = firstNotNull(value, "");
   
    return new CacheDirective._internal(key, value);
  }
  
  factory CacheDirective.createWithDigitValue(String key, int value) {
    checkArgument(TCHAR.matchesAllOf(key));
    checkArgument(value >= 0);
    checkArgument(value <= 2147483648);
   
    return new CacheDirective._internal(key.toLowerCase(), value.toString());
  }
  
  factory CacheDirective.maxAge(final int seconds) {
    checkArgument(seconds >= 0);
    return new CacheDirective._internal(_MAX_AGE_NAME, seconds.toString());
  }
  
  factory CacheDirective.maxStale(final int seconds) {
    checkArgument(seconds >= 0);
    return new CacheDirective._internal(_MAX_STALE_NAME, seconds.toString());
  }
  
  factory CacheDirective.minFresh(final int seconds) {
    checkArgument(seconds >= 0);
    return new CacheDirective._internal(_MIN_FRESH_NAME, seconds.toString());
  }
  
  factory CacheDirective.noCache(final Iterable<Header> fields) {
    if (fields.isEmpty) {
      return CacheDirective.NO_CACHE;
    }
    return new CacheDirective._internal(_NO_CACHE_NAME, fields.join(", "));
  }
  
  factory CacheDirective.privateInfo(final Iterable<Header> fields) {
    if (fields.isEmpty) {
      return CacheDirective.PRIVATE;
    }
    return new CacheDirective._internal(_PRIVATE_NAME, fields.join(", "));
  }
  
  factory CacheDirective.sharedMaxAge(final int seconds) {
    checkArgument(seconds > 0);
    return new CacheDirective._internal(_SHARED_MAX_AGE_NAME, seconds.toString());
  }
  
  final String fst;
  final String snd;
  
  const CacheDirective._internal(this.fst, this.snd);

  int get hashCode => computeHashCode([fst, snd]);
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is CacheDirective) {
      CacheDirective that = other;
      return this.fst == that.fst &&
          this.snd == that.snd;
    } else {
      return false;
    }
  }
  
  String toString() => 
      snd.isEmpty ? fst : "$fst=$snd";
}