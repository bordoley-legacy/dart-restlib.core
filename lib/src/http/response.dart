part of http;

void writeResponseHeaders(final Response response, void writeHeaderLine(final String header, final String value)) {
  _writeHeader(ACCEPT_RANGES, response.acceptedRangeUnits, writeHeaderLine);
  _writeHeader(AGE, response.age, writeHeaderLine);
  _writeHeader(ALLOW, response.allowedMethods, writeHeaderLine);
  _writeHeader(CACHE_CONTROL, response.cacheDirectives, writeHeaderLine);
  _writeContentInfo(response.contentInfo, writeHeaderLine);
  _writeHeader(DATE, response.date, writeHeaderLine);
  _writeHeader(ENTITY_TAG, response.entityTag, writeHeaderLine);
  _writeHeader(EXPIRES, response.expires, writeHeaderLine);
  _writeHeader(LAST_MODIFIED, response.lastModified, writeHeaderLine);
  _writeHeader(LOCATION, response.location, writeHeaderLine);
  _writeHeader(PROXY_AUTHENTICATE, response.proxyAuthenticationChallenges, writeHeaderLine);
  _writeHeader(RETRY_AFTER, response.retryAfter, writeHeaderLine);
  _writeHeader(SERVER, response.server, writeHeaderLine);

  response.setCookies.forEach((final SetCookie setCookie) =>
      _writeHeader(SET_COOKIE, setCookie, writeHeaderLine));

  _writeHeader(VARY, response.vary, writeHeaderLine);
  _writeHeader(WARNING, response.warnings, writeHeaderLine);
  _writeHeader(WWW_AUTHENTICATE, response.authenticationChallenges, writeHeaderLine);

  response.customHeaders.forEach((final Pair<Header, dynamic> header) =>
      _writeHeader(header.e0, header.e1, writeHeaderLine));
}

String _responseToString(final Response response) {
  final StringBuffer buffer = new StringBuffer();

  _WriteHeaderLine writeHeaderLine = _writeHeaderToBuffer(buffer);
  buffer.write("${response.status}\r\n");

  writeResponseHeaders(response, writeHeaderLine);

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

  factory Response.wrapHeaders(final Status status, final Multimap<Header, String, dynamic> headers, [final T entity = null]) =>
       new _HeadersResponseWrapper(headers, status, new Option(entity));

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

class _HeadersResponseWrapper<T>
    extends Object
    with _ResponseMixin<T>,
      _Parseable
    implements Response<T> {
  final Status status;
  final Multimap<Header, String, dynamic> _headers;

  ImmutableSet<RangeUnit> _acceptedRangeUnits;
  Option<int> _age;
  ImmutableSet<Method> _allowedMethods;
  ImmutableSet<ChallengeMessage> _authenticationChallenges;
  ImmutableSet<CacheDirective> _cacheDirectives;
  ContentInfo _contentInfo;
  Dictionary<Header, dynamic> _customHeaders;
  Option<DateTime> _date;
  Option<T> entity;
  Option<EntityTag> _entityTag;
  Option<DateTime> _expires;
  Option<DateTime> _lastModified;
  Option<URI> _location;
  ImmutableSet<ChallengeMessage> _proxyAuthenticationChallenges;
  Option<DateTime> _retryAfter;
  Option<UserAgent> _server;
  FiniteSet<SetCookie> _setCookies;
  ImmutableSet<Header> _vary;
  ImmutableSequence<Warning> _warnings;

  _HeadersResponseWrapper(this._headers, this.status, this.entity);

  FiniteSet<RangeUnit> get acceptedRangeUnits =>
      EMPTY_SET;

  Option<int> get age =>
      Option.NONE; // FIXME

  FiniteSet<Method> get allowedMethods =>
      EMPTY_SET;

  FiniteSet<ChallengeMessage> get authenticationChallenges =>
      EMPTY_SET;

  FiniteSet<CacheDirective> get cacheDirectives =>
      computeIfNull(_cacheDirectives, () {
        _cacheDirectives = _parse(_CACHE_CONTROL, CACHE_CONTROL).map(EMPTY_SET.addAll).orElse(EMPTY_SET);
        return _cacheDirectives;
      });

  ContentInfo get contentInfo =>
      computeIfNull(_contentInfo, () {
        _contentInfo = new ContentInfo.wrapHeaders(_headers);
        return _contentInfo;
      });

  Dictionary<Header, dynamic> get customHeaders =>
      computeIfNull(_customHeaders, () {
        _customHeaders =
            _headers.dictionary
              .filterKeys((final Header header) =>
                  !_standardHeaders.contains(header))
              .mapValues((final Sequence<String> values) =>
                  // FIXME: Verify this is correct.
                  values.join(","));
        return _customHeaders;
      });

  Option<DateTime> get date =>
      Option.NONE; // FIXME

  Option<EntityTag> get entityTag =>
      Option.NONE; // FIXME

  Option<DateTime> get expires =>
      Option.NONE; // FIXME

  Option<DateTime> get lastModified =>
      Option.NONE; // FIXME

  Option<URI> get location =>
      computeIfNull(_location, () {
        _location = first(_headers[LOCATION]).flatMap((final String uri) =>
            URI.parser.parse(uri).left);
        return _location;
      });

  FiniteSet<ChallengeMessage> get proxyAuthenticationChallenges =>
      EMPTY_SET;

  Option<DateTime> get retryAfter =>
      Option.NONE; // FIXME

  Option<UserAgent> get server =>
      computeIfNull(_server, () {
        _server = _parse(UserAgent.parser, SERVER);
        return _server;
      });

  FiniteSet<SetCookie> get setCookies =>
      EMPTY_SET;

  FiniteSet<Header> get vary =>
      computeIfNull(_vary, () {
        _vary = _parse(_VARY, VARY).map(EMPTY_SET.addAll).orElse(EMPTY_SET);
        return _vary;
      });

  Sequence<Warning> get warnings =>
      computeIfNull(_warnings, () {
        _warnings = _parse(_WARNING, WARNING).map(EMPTY_SEQUENCE.addAll).orElse(EMPTY_SEQUENCE);
        return _warnings;
      });
}