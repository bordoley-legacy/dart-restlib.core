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
       new _ResponseImpl(
           null, null, null, null, null, null, null, null,
           new Option(entity),
           null, null, null, null, null, null, null, null,
           checkNotNull(status),
           null, null,
           headers);

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

class _ResponseImpl<T>
    extends Object
    with _Parseable
    implements Response<T> {
  final Option<T> entity;
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

  _ResponseImpl(
      this._acceptedRangeUnits,
      this._age,
      this._allowedMethods,
      this._authenticationChallenges,
      this._cacheDirectives,
      this._contentInfo,
      this._customHeaders,
      this._date,
      this.entity,
      this._entityTag,
      this._expires,
      this._lastModified,
      this._location,
      this._proxyAuthenticationChallenges,
      this._retryAfter,
      this._server,
      this._setCookies,
      this.status,
      this._vary,
      this._warnings, [this._headers = EMPTY_SEQUENCE_MULTIMAP]);

  FiniteSet<RangeUnit> get acceptedRangeUnits =>
      computeIfNull(_acceptedRangeUnits, () {
        _acceptedRangeUnits = EMPTY_SET;
        return _acceptedRangeUnits;
      });

  Option<int> get age =>
      computeIfNull(_age, () {
        _age = Option.NONE;
        return _age;
      });

  FiniteSet<Method> get allowedMethods =>
      computeIfNull(_allowedMethods, () {
        _allowedMethods = _parse(_ALLOW, ALLOW).map(EMPTY_SET.addAll).orElse(EMPTY_SET);
        return _allowedMethods;
      });

  FiniteSet<ChallengeMessage> get authenticationChallenges =>
      computeIfNull(_authenticationChallenges, () {
        _authenticationChallenges = EMPTY_SET;
        return _authenticationChallenges;
      });

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
      computeIfNull(_date, () {
        _date = Option.NONE;
        return _date;
      });

  Option<EntityTag> get entityTag =>
      computeIfNull(_entityTag, () {
        _entityTag = Option.NONE;
        return _entityTag;
      });

  Option<DateTime> get expires =>
      computeIfNull(_expires, () {
        _expires = Option.NONE;
        return _expires;
      });

  Option<DateTime> get lastModified =>
      computeIfNull(_lastModified, () {
        _lastModified = Option.NONE;
        return _lastModified;
      });

  Option<URI> get location =>
      computeIfNull(_location, () {
        _location = first(_headers[LOCATION]).flatMap((final String uri) =>
            URI.parser.parse(uri).left);
        return _location;
      });

  FiniteSet<ChallengeMessage> get proxyAuthenticationChallenges =>
      computeIfNull(_proxyAuthenticationChallenges, () {
        _proxyAuthenticationChallenges = EMPTY_SET;
        return _proxyAuthenticationChallenges;
      });

  Option<DateTime> get retryAfter =>
      computeIfNull(_retryAfter, () {
        _retryAfter = Option.NONE;
        return _retryAfter;
      });

  Option<UserAgent> get server =>
      computeIfNull(_server, () {
        _server = _parse(UserAgent.parser, SERVER);
        return _server;
      });

  FiniteSet<SetCookie> get setCookies =>
      computeIfNull(_setCookies, () {
        _setCookies = EMPTY_SET;
        return _setCookies;
      });

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

  String toString() {
    final StringBuffer buffer = new StringBuffer();

    buffer.write("${status}\r\n");

    writeResponseHeaders(this, _writeHeaderToBuffer(buffer));

    buffer.write(entity.map((final entity) =>
        "\r\n\r\n${entity.toString()}\r\n").orElse(""));

    return buffer.toString();
  }

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
      final Iterable<Warning> warnings}) {

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
      return this;
    }

    return new _ResponseImpl(
        isNotNull(acceptedRangeUnits) ? EMPTY_SET.addAll(acceptedRangeUnits) : _acceptedRangeUnits,
        computeIfEmpty(new Option(age), () => _age),
        isNotNull(allowedMethods) ? EMPTY_SET.addAll(allowedMethods) : _allowedMethods,
        isNotNull(authenticationChallenges) ? EMPTY_SET.addAll(authenticationChallenges) : _authenticationChallenges,
        isNotNull(cacheDirectives) ? EMPTY_SET.addAll(cacheDirectives) : _cacheDirectives,
        isNotNull(contentInfo) ? contentInfo : _contentInfo,
        isNotNull(customHeaders) ? EMPTY_DICTIONARY.putAll(customHeaders) : _customHeaders,
        computeIfEmpty(new Option(date), () => _date),
        computeIfEmpty(new Option(entity), () => this.entity),
        computeIfEmpty(new Option(entityTag), () => _entityTag),
        computeIfEmpty(new Option(expires), () => _expires),
        computeIfEmpty(new Option(lastModified), () => _lastModified),
        computeIfEmpty(new Option(location), () => _location),
        isNotNull(proxyAuthenticationChallenges) ? EMPTY_SET.addAll(proxyAuthenticationChallenges) : _proxyAuthenticationChallenges,
        computeIfEmpty(new Option(retryAfter), () => _retryAfter),
        computeIfEmpty(new Option(server), () => _server),
        isNotNull(setCookies) ? EMPTY_SET.addAll(setCookies) : _setCookies,
        firstNotNull(status, this.status),
        isNotNull(vary) ? EMPTY_SET.addAll(vary) : _vary,
        isNotNull(warnings) ? EMPTY_SEQUENCE.addAll(warnings) : _warnings,
        _headers);
  }

  Response without({
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
      final bool warnings}) =>
        new _ResponseImpl(
          acceptedRangeUnits ? EMPTY_SET : _acceptedRangeUnits,
          age ? Option.NONE : _age,
          allowedMethods ? EMPTY_SET : _allowedMethods,
          authenticationChallenges ? EMPTY_SET : _authenticationChallenges,
          cacheDirectives ? EMPTY_SET : _cacheDirectives,
          contentInfo ? ContentInfo.NONE : _contentInfo,
          customHeaders ? EMPTY_DICTIONARY : _customHeaders,
          date ? Option.NONE : _date,
          entity ? Option.NONE : this.entity,
          entityTag ? Option.NONE : _entityTag,
          expires ? Option.NONE : _expires,
          lastModified ? Option.NONE : _lastModified,
          location ? Option.NONE : _location,
          proxyAuthenticationChallenges ? EMPTY_SET : _proxyAuthenticationChallenges,
          retryAfter ? Option.NONE : _retryAfter,
          server ? Option.NONE : _server,
          setCookies ? EMPTY_SET : _setCookies,
          delegate.status,
          vary ? EMPTY_SET : _vary,
          warnings ? EMPTY_SEQUENCE : _warnings,
          _headers);
}