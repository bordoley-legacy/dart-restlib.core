part of restlib.core.http;

String _responseToString(final Response response) {
    final StringBuffer buffer =
        (new StringBuffer()
          ..write("${response.status}\r\n")
          ..write(_headerLine(ACCEPT_RANGES, response.acceptedRangeUnits))
          ..write(_headerLine(AGE, response.age))
          ..write(_headerLine(ALLOW, response.allowedMethods))
          ..write(_headerLine(WWW_AUTHENTICATE, response.authenticationChallenges))
          ..write(_headerLine(CACHE_CONTROL, response.cacheDirectives))
          ..write(response.contentInfo)
          ..write(_headerLine(DATE, response.date))
          ..write(_headerLine(ENTITY_TAG, response.entityTag))
          ..write(_headerLine(EXPIRES, response.expires))
          ..write(_headerLine(LAST_MODIFIED, response.lastModified))
          ..write(_headerLine(LOCATION, response.location))
          ..write(_headerLine(PROXY_AUTHENTICATE, response.proxyAuthenticationChallenges))
          ..write(_headerLine(RETRY_AFTER, response.retryAfter))
          ..write(_headerLine(SERVER, response.server))
          ..write(response.setCookies.map((final SetCookie setCookie) => _headerLine(SET_COOKIE, setCookie)).join())
          ..write(_headerLine(VARY, response.vary)));

  response.customHeaders.forEach((final Pair<Header, dynamic> header) =>
      buffer.write(_headerLine(header.fst, header.snd)));

  buffer.write(response.entity.map((final entity) =>
      "\r\n\r\n${entity.toString()}\r\n").orElse(""));

  return buffer.toString();
}

Response _responseWith(
  final Response delegate,
  final Iterable<RangeUnit> acceptedRangeUnits,
  final int age,
  final Iterable<Method> allowedMethods,
  final Iterable<ChallengeMessage> authenticationChallenges,
  final Iterable<CacheDirective> cacheDirectives,
  final ContentInfo contentInfo,
  final Dictionary<Header, dynamic> customHeaders,
  final DateTime date,
  final entity,
  final EntityTag entityTag,
  final DateTime expires,
  final DateTime lastModified,
  final URI location,
  final Iterable<ChallengeMessage> proxyAuthenticationChallenges,
  final DateTime retryAfter,
  final UserAgent server,
  final Iterable<SetCookie> setCookies,
  final Status status,
  final Iterable<Header> vary,
  final Iterable<Warning> warnings) {

  if(isNull(acceptedRangeUnits) &&
      isNull(age) &&
      isNull(allowedMethods) &&
      isNull(authenticationChallenges) &&
      isNull(cacheDirectives) &&
      isNull(contentInfo) &&
      isNull(customHeaders) &&
      isNull(date) &&
      isNull(entity) &&
      isNull(entityTag) &&
      isNull(expires) &&
      isNull(lastModified) &&
      isNull(location) &&
      isNull(proxyAuthenticationChallenges) &&
      isNull(retryAfter) &&
      isNull(server) &&
      isNull(setCookies) &&
      isNull(status) &&
      isNull(vary) &&
      isNull(warnings)) {
    return delegate;
  }

  return new _ResponseImpl(
      EMPTY_SET.addAll(firstNotNull(acceptedRangeUnits, delegate.acceptedRangeUnits)),
      computeIfEmpty(new Option(age), () => delegate.age),
      EMPTY_SET.addAll(firstNotNull(allowedMethods, delegate.allowedMethods)),
      EMPTY_SET.addAll(firstNotNull(authenticationChallenges, delegate.authenticationChallenges)),
      EMPTY_SET.addAll(firstNotNull(cacheDirectives, delegate.cacheDirectives)),
      firstNotNull(contentInfo, delegate.contentInfo),
      EMPTY_DICTIONARY.putAll(firstNotNull(customHeaders, delegate.customHeaders)),
      computeIfEmpty(new Option(date), () => delegate.date),
      computeIfEmpty(new Option(entity), () => delegate.entity),
      computeIfEmpty(new Option(entityTag), () => delegate.entityTag),
      computeIfEmpty(new Option(expires), () => delegate.expires),
      computeIfEmpty(new Option(lastModified), () => delegate.lastModified),
      computeIfEmpty(new Option(location), () => delegate.location),
      EMPTY_SET.addAll(firstNotNull(proxyAuthenticationChallenges, delegate.proxyAuthenticationChallenges)),
      computeIfEmpty(new Option(retryAfter), () => delegate.retryAfter),
      computeIfEmpty(new Option(server), () => delegate.server),
      EMPTY_SET.addAll(firstNotNull(setCookies, delegate.setCookies)),
      firstNotNull(status, delegate.status),
      EMPTY_SET.addAll(firstNotNull(vary, delegate.vary)),
      EMPTY_SEQUENCE.addAll(firstNotNull(warnings, delegate.warnings)));
}

Response _responseWithout(
  final Response delegate,
  final bool acceptedRangeUnits,
  final bool age,
  final bool allowedMethods,
  final bool authenticationChallenges,
  final bool cacheDirectives,
  final bool contentInfo,
  final bool customHeaders,
  final bool date,
  final bool entity,
  final bool entityTag,
  final bool expires,
  final bool lastModified,
  final bool location,
  final bool proxyAuthenticationChallenges,
  final bool retryAfter,
  final bool server,
  final bool setCookies,
  final bool vary,
  final bool warnings) =>
      new _ResponseImpl(
          !acceptedRangeUnits ? EMPTY_SET.addAll(delegate.acceptedRangeUnits) : EMPTY_SET,
          !age ? delegate.age : Option.NONE,
          !allowedMethods ? EMPTY_SET.addAll(delegate.allowedMethods) : EMPTY_SET,
          !authenticationChallenges ? EMPTY_SET.addAll(delegate.authenticationChallenges) : EMPTY_SET,
          !cacheDirectives ? EMPTY_SET.addAll(delegate.authenticationChallenges) : EMPTY_SET,
          !contentInfo ? delegate.contentInfo : ContentInfo.NONE,
          !customHeaders ? EMPTY_DICTIONARY.putAll(delegate.customHeaders) : EMPTY_DICTIONARY,
          !date ? delegate.date : Option.NONE,
          !entity ? delegate.entity : Option.NONE,
          !entityTag ? delegate.entityTag : Option.NONE,
          !expires ? delegate.expires : Option.NONE,
          !lastModified ? delegate.lastModified : Option.NONE,
          !location ? delegate.location : Option.NONE,
          !proxyAuthenticationChallenges ? EMPTY_SET.addAll(delegate.proxyAuthenticationChallenges) : EMPTY_SET,
          !retryAfter ? delegate.retryAfter : Option.NONE,
          !server ? delegate.server : Option.NONE,
          !setCookies ? EMPTY_SET.addAll(delegate.setCookies) : EMPTY_SET,
          delegate.status,
          !vary ? EMPTY_SET.addAll(delegate.vary) : EMPTY_SET,
          !warnings ? EMPTY_SEQUENCE.addAll(delegate.warnings) :  EMPTY_SEQUENCE);

abstract class Response<T> {
  factory Response(
    final Status status, {
    final Iterable<RangeUnit> acceptedRangeUnits,
    final int age,
    final Iterable<Method> allowedMethods,
    final Iterable<ChallengeMessage> authenticationChallenges,
    final Iterable<CacheDirective> cacheDirectives,
    final ContentInfo contentInfo,
    final Dictionary<Header, dynamic> customHeaders,
    final DateTime date,
    final T entity,
    final EntityTag entityTag,
    final DateTime expires,
    final DateTime lastModified,
    final URI location,
    final Iterable<ChallengeMessage> proxyAuthenticationChallenges,
    final DateTime retryAfter,
    final UserAgent server,
    final Iterable<SetCookie> setCookies,
    final Iterable<Header> vary,
    final Iterable<Warning> warnings}) =>
        new _ResponseImpl(
            EMPTY_SET.addAll(firstNotNull(acceptedRangeUnits, EMPTY_LIST)),
            new Option(age),
            EMPTY_SET.addAll(firstNotNull(allowedMethods, EMPTY_LIST)),
            EMPTY_SET.addAll(firstNotNull(authenticationChallenges, EMPTY_LIST)),
            EMPTY_SET.addAll(firstNotNull(cacheDirectives, EMPTY_LIST)),
            firstNotNull(contentInfo, ContentInfo.NONE),
            EMPTY_DICTIONARY.putAll(firstNotNull(customHeaders, EMPTY_DICTIONARY)),
            new Option(date),
            new Option(entity),
            new Option(entityTag),
            new Option(expires),
            new Option(lastModified),
            new Option(location),
            EMPTY_SET.addAll(firstNotNull(proxyAuthenticationChallenges, EMPTY_LIST)),
            new Option(retryAfter),
            new Option(server),
            EMPTY_SET.addAll(firstNotNull(setCookies, EMPTY_LIST)),
            status,
            EMPTY_SET.addAll(firstNotNull(vary, EMPTY_LIST)),
            EMPTY_SEQUENCE.addAll(firstNotNull(warnings, EMPTY_LIST)));

  FiniteSet<RangeUnit> get acceptedRangeUnits;

  Option<int> get age;

  FiniteSet<Method> get allowedMethods;

  FiniteSet<ChallengeMessage> get authenticationChallenges;

  FiniteSet<CacheDirective> get cacheDirectives;

  ContentInfo get contentInfo;

  Dictionary<Header, dynamic> get customHeaders;

  Option<DateTime> get date;

  Option<T> get entity;

  Option<EntityTag> get entityTag;

  Option<DateTime> get expires;

  Option<DateTime> get lastModified;

  Option<URI> get location;

  FiniteSet<ChallengeMessage> get proxyAuthenticationChallenges;

  Option<DateTime> get retryAfter;

  Option<UserAgent> get server;

  FiniteSet<SetCookie> get setCookies;

  Status get status;

  FiniteSet<Header> get vary;

  Sequence<Warning> get warnings;

  String toString();

  Response with_({
    Iterable<RangeUnit> acceptedRangeUnits,
    int age,
    Iterable<Method> allowedMethods,
    Iterable<ChallengeMessage> authenticationChallenges,
    Iterable<CacheDirective> cacheDirectives,
    ContentInfo contentInfo,
    Dictionary<Header, dynamic> customHeaders,
    DateTime date,
    entity,
    EntityTag entityTag,
    DateTime expires,
    DateTime lastModified,
    URI location,
    Iterable<ChallengeMessage> proxyAuthenticationChallenges,
    DateTime retryAfter,
    UserAgent server,
    Iterable<SetCookie> setCookies,
    Status status,
    Iterable<Header> vary,
    Iterable<Warning> warnings});

  Response without({
    bool acceptedRangeUnits : false,
    bool age : false,
    bool allowedMethods : false,
    bool authenticationChallenges : false,
    bool cacheDirectives : false,
    bool contentInfo : false,
    bool customHeaders : false,
    bool date : false,
    bool entity : false,
    bool entityTag : false,
    bool expires : false,
    bool lastModified : false,
    bool location : false,
    bool proxyAuthenticationChallenges : false,
    bool retryAfter : false,
    bool server : false,
    bool setCookies : false,
    bool vary : false,
    bool warnings : false});
}

abstract class _ResponseMixin<T> implements Response<T> {
  String toString() =>
      _responseToString(this);

  Response with_({
    final Iterable<RangeUnit> acceptedRangeUnits,
    final int age,
    final Iterable<Method> allowedMethods,
    final Iterable<ChallengeMessage> authenticationChallenges,
    final Iterable<CacheDirective> cacheDirectives,
    final ContentInfo contentInfo,
    final Dictionary<Header, dynamic> customHeaders,
    final DateTime date,
    final entity,
    final EntityTag entityTag,
    final DateTime expires,
    final DateTime lastModified,
    final URI location,
    final Iterable<ChallengeMessage> proxyAuthenticationChallenges,
    final DateTime retryAfter,
    final UserAgent server,
    final Iterable<SetCookie> setCookies,
    final Status status,
    final Iterable<Header> vary,
    final Iterable<Warning> warnings}) =>
        _responseWith(
            this,
            acceptedRangeUnits,
            age,
            allowedMethods,
            authenticationChallenges,
            cacheDirectives,
            contentInfo,
            customHeaders,
            date,
            entity,
            entityTag,
            expires,
            lastModified,
            location,
            proxyAuthenticationChallenges,
            retryAfter,
            server,
            setCookies,
            status,
            vary,
            warnings);

  Response without({
    final bool acceptedRangeUnits : false,
    final bool age : false,
    final bool allowedMethods : false,
    final bool authenticationChallenges : false,
    final bool cacheDirectives : false,
    final bool contentInfo : false,
    final bool customHeaders : false,
    final bool date : false,
    final bool entity : false,
    final bool entityTag : false,
    final bool expires : false,
    final bool lastModified : false,
    final bool location : false,
    final bool proxyAuthenticationChallenges : false,
    final bool retryAfter : false,
    final bool server : false,
    final bool setCookies : false,
    final bool vary : false,
    final bool warnings : false}) =>
        _responseWithout(
            this,
            acceptedRangeUnits,
            age,
            allowedMethods,
            authenticationChallenges,
            cacheDirectives,
            contentInfo,
            customHeaders,
            date,
            entity,
            entityTag,
            expires,
            lastModified,
            location,
            proxyAuthenticationChallenges,
            retryAfter,
            server,
            setCookies,
            vary,
            warnings);
}

class _ResponseImpl<T>
    extends Object
    with _ResponseMixin<T>
    implements Response<T> {
  final ImmutableSet<RangeUnit> acceptedRangeUnits;
  final Option<int> age;
  final ImmutableSet<Method> allowedMethods;
  final ImmutableSet<ChallengeMessage> authenticationChallenges;
  final ImmutableSet<CacheDirective> cacheDirectives;
  final ContentInfo contentInfo;
  final ImmutableDictionary<Header, dynamic> customHeaders;
  final Option<DateTime> date;
  final Option<T> entity;
  final Option<EntityTag> entityTag;
  final Option<DateTime> expires;
  final Option<DateTime> lastModified;
  final Option<URI> location;
  final ImmutableSet<ChallengeMessage> proxyAuthenticationChallenges;
  final Option<DateTime> retryAfter;
  final Option<UserAgent> server;
  final FiniteSet<SetCookie> setCookies;
  final Status status;
  final ImmutableSet<Header> vary;
  final ImmutableSequence<Warning> warnings;

  _ResponseImpl(
    this.acceptedRangeUnits,
    this.age,
    this.allowedMethods,
    this.authenticationChallenges,
    this.cacheDirectives,
    this.contentInfo,
    this.customHeaders,
    this.date,
    this.entity,
    this.entityTag,
    this.expires,
    this.lastModified,
    this.location,
    this.proxyAuthenticationChallenges,
    this.retryAfter,
    this.server,
    this.setCookies,
    this.status,
    this.vary,
    this.warnings);
}