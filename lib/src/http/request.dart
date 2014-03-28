part of http;

void writeRequestHeaders(final Request request, void writeHeaderLine(final String header, final String value)) {
  _writeHeader(HOST, request.uri.authority.value.host.value.toString(), writeHeaderLine);
  _writeHeader(AUTHORIZATION, request.authorizationCredentials, writeHeaderLine);
  _writeHeader(CACHE_CONTROL, request.cacheDirectives, writeHeaderLine);
  _writeContentInfo(request.contentInfo, writeHeaderLine);
  _writeHeader(COOKIE, request.cookies, writeHeaderLine);
  _writeHeader(EXPECT, request.expectations, writeHeaderLine);
  _writeHeader(PRAGMA, request.pragmaCacheDirectives, writeHeaderLine);
  _writeRequestPreconditions(request.preconditions, writeHeaderLine);
  _writeRequestPreferences(request.preferences, writeHeaderLine);
  _writeHeader(PROXY_AUTHORIZATION, request.proxyAuthorizationCredentials, writeHeaderLine);
  _writeHeader(REFERER, request.referer, writeHeaderLine);
  _writeHeader(USER_AGENT, request.userAgent, writeHeaderLine);

  request.customHeaders.forEach((final Pair<Header, dynamic> header) =>
     _writeHeader(header.e0, header.e1, writeHeaderLine));
}

abstract class Request<T> {
  factory Request(final Method method, final uri, {
    final ChallengeMessage authorizationCredentials,
    final Iterable<CacheDirective> cacheDirectives,
    final ContentInfo contentInfo,
    final Iterable<Cookie> cookies,
    final Dictionary<Header, dynamic> customHeaders,
    final T entity,
    final Iterable<Expectation> expectations,
    final Iterable<CacheDirective> pragmaCacheDirectives,
    final RequestPreconditions preconditions,
    final RequestPreferences preferences,
    final ChallengeMessage proxyAuthorizationCredentials,
    final URI referer,
    final UserAgent userAgent,
    final HttpVersion version: HttpVersion.v1_1}) =>
        new _RequestImpl(
            checkNotNull(method), checkNotNull(uri),
            new Option(authorizationCredentials),
            EMPTY_SET.addAll(firstNotNull(cacheDirectives, EMPTY_LIST)),
            firstNotNull(contentInfo, ContentInfo.NONE),
            CookieMultimap.EMPTY.putAll(firstNotNull(cookies, EMPTY_LIST)),
            EMPTY_DICTIONARY.putAll(firstNotNull(customHeaders, EMPTY_DICTIONARY)),
            new Option(entity),
            EMPTY_SET.addAll(firstNotNull(expectations, EMPTY_LIST)),
            EMPTY_SET.addAll(firstNotNull(pragmaCacheDirectives, EMPTY_LIST)),
            firstNotNull(preconditions, RequestPreconditions.NONE),
            firstNotNull(preferences, RequestPreferences.NONE),
            new Option(proxyAuthorizationCredentials),
            new Option(referer),
            new Option(userAgent),
            checkNotNull(version));

  factory Request.wrapHeaders(
        final Method method, final URI uri,
        final Multimap<Header, String, dynamic> headers, {final HttpVersion version: HttpVersion.v1_1}) =>
      new _RequestImpl(checkNotNull(method), checkNotNull(uri),
          null, null, null, null, null,
          Option.NONE,
          null, null, null, null, null, null, null,
          checkNotNull(version),
          checkNotNull(headers));

  Option<ChallengeMessage> get authorizationCredentials;

  FiniteSet<CacheDirective> get cacheDirectives;

  ContentInfo get contentInfo;

  CookieMultimap get cookies;

  Dictionary<Header, dynamic> get customHeaders;

  Option<T> get entity;

  FiniteSet<Expectation> get expectations;

  Method get method;

  FiniteSet<CacheDirective> get pragmaCacheDirectives;

  RequestPreconditions get preconditions;

  RequestPreferences get preferences;

  Option<ChallengeMessage> get proxyAuthorizationCredentials;

  Option<URI> get referer;

  URI get uri;

  Option<UserAgent> get userAgent;

  HttpVersion get version;

  String toString();

  Request with_({
    ChallengeMessage authorizationCredentials,
    Iterable<CacheDirective> cacheDirectives,
    ContentInfo contentInfo,
    Iterable<Cookie> cookies,
    Dictionary<Header, dynamic> customHeaders,
    entity,
    Iterable<Expectation> expectations,
    Method method,
    Iterable<CacheDirective> pragmaCacheDirectives,
    RequestPreconditions preconditions,
    RequestPreferences preferences,
    ChallengeMessage proxyAuthorizationCredentials,
    URI referer,
    URI uri,
    UserAgent userAgent,
    HttpVersion version});

  Request without({
    bool authorizationCredentials : false,
    bool cacheDirectives : false,
    bool contentInfo : false,
    bool cookies : false,
    bool customHeaders : false,
    bool entity : false,
    bool expectations : false,
    bool pragmaCacheDirectives : false,
    bool preconditions : false,
    bool preferences : false,
    bool proxyAuthorizationCredentials : false,
    bool referer : false,
    bool userAgent : false});
}

class _RequestImpl<T>
    extends Object
    with _Parseable
    implements Request<T> {
  Option<ChallengeMessage> _authorizationCredentials;
  ImmutableSet<CacheDirective> _cacheDirectives;
  ContentInfo _contentInfo;
  CookieMultimap _cookies;
  Dictionary<Header, dynamic> _customHeaders;
  final Option<T> entity;
  ImmutableSet<Expectation> _expectations;
  final Multimap<Header, String, dynamic> _headers;
  final Method method;
  ImmutableSet<CacheDirective> _pragmaCacheDirectives;
  RequestPreconditions _preconditions;
  RequestPreferences _preferences;
  Option<ChallengeMessage> _proxyAuthorizationCredentials;
  Option<URI> _referer;
  final URI uri;
  Option<UserAgent> _userAgent;
  HttpVersion version;

  _RequestImpl(this.method, this.uri,
      this._authorizationCredentials,
      this._cacheDirectives,
      this._contentInfo,
      this._cookies,
      this._customHeaders,
      this.entity,
      this._expectations,
      this._pragmaCacheDirectives,
      this._preconditions,
      this._preferences,
      this._proxyAuthorizationCredentials,
      this._referer,
      this._userAgent,
      this.version,
      [this._headers = EMPTY_SEQUENCE_MULTIMAP]);

  Option<ChallengeMessage> get authorizationCredentials =>
      computeIfNull(_authorizationCredentials, () {
        _authorizationCredentials = _parse(ChallengeMessage.parser, AUTHORIZATION);
        return _authorizationCredentials;
      });

  ImmutableSet<CacheDirective> get cacheDirectives =>
      computeIfNull(_cacheDirectives, () {
        _cacheDirectives = _parse(_CACHE_CONTROL, CACHE_CONTROL).map(EMPTY_SET.addAll).orElse(EMPTY_SET);
        return _cacheDirectives;
      });

  ContentInfo get contentInfo =>
      computeIfNull(_contentInfo, () {
        _contentInfo = new ContentInfo.wrapHeaders(_headers);
        return _contentInfo;
      });

  CookieMultimap get cookies =>
      computeIfNull(_cookies, () {
        _cookies = _parse(_COOKIE, COOKIE).orElse(CookieMultimap.EMPTY);
        return _cookies;
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

  ImmutableSet<Expectation> get expectations =>
      computeIfNull(_expectations, () {
        _expectations = _parse(_EXPECT, EXPECT).map(EMPTY_SET.addAll).orElse(EMPTY_SET);
        return _expectations;
      });

  ImmutableSet<CacheDirective> get pragmaCacheDirectives =>
      computeIfNull(_pragmaCacheDirectives, () {
        _pragmaCacheDirectives = _parse(_PRAGMA, PRAGMA).map(EMPTY_SET.addAll).orElse(EMPTY_SET);
        return _pragmaCacheDirectives;
      });

  RequestPreconditions get preconditions =>
      computeIfNull(_preconditions, () {
        _preconditions = new RequestPreconditions.wrapHeaders(_headers);
        return _preconditions;
      });

  RequestPreferences get preferences =>
      computeIfNull(_preferences, () {
        _preferences = new RequestPreferences.wrapHeaders(_headers);
        return _preferences;
      });

  Option<ChallengeMessage> get proxyAuthorizationCredentials =>
      computeIfNull(_proxyAuthorizationCredentials, () {
        _proxyAuthorizationCredentials = _parse(ChallengeMessage.parser, PROXY_AUTHORIZATION);
        return _proxyAuthorizationCredentials;
      });

  Option<URI> get referer =>
      computeIfNull(_referer, () {
        _referer = first(_headers[REFERER]).flatMap((final String uri) =>
                URI.parser.parse(uri).left);
        return _referer;
      });

  Option<UserAgent> get userAgent =>
      computeIfNull(_userAgent, () {
        _userAgent = _parse(UserAgent.parser, USER_AGENT);
        return _userAgent;
      });

  String toString() {
    final StringBuffer buffer = new StringBuffer();

    final String requestLine = "${method} ${uri.path}${uri.query.isEmpty ? "" : "?${uri.query}"} $version\r\n";
    buffer.write(requestLine);

    writeRequestHeaders(this, _writeHeaderToBuffer(buffer));

    buffer.write(entity.map((final entity) =>
        "\r\n\r\n${entity.toString()}\r\n").orElse(""));

    return buffer.toString();
  }

  Request with_({
      final ChallengeMessage authorizationCredentials,
      final Iterable<CacheDirective> cacheDirectives,
      final ContentInfo contentInfo,
      final Iterable<Cookie> cookies,
      final Dictionary<Header, dynamic> customHeaders,
      final entity,
      final Iterable<Expectation> expectations,
      final Method method,
      final Iterable<CacheDirective> pragmaCacheDirectives,
      final RequestPreconditions preconditions,
      final RequestPreferences preferences,
      final ChallengeMessage proxyAuthorizationCredentials,
      final URI referer,
      final URI uri,
      final UserAgent userAgent,
      HttpVersion version}) {

    if (isNull(authorizationCredentials) &&
        isNull(cacheDirectives) &&
        isNull(contentInfo) &&
        isNull(cookies) &&
        isNull(customHeaders) &&
        isNull(entity) &&
        isNull(expectations) &&
        isNull(method) &&
        isNull(pragmaCacheDirectives) &&
        isNull(preconditions) &&
        isNull(preferences) &&
        isNull(proxyAuthorizationCredentials) &&
        isNull(referer) &&
        isNull(uri) &&
        isNull(userAgent) &&
        isNull(version)) {
      return this;
    }

    return new _RequestImpl(
      firstNotNull(method, this.method),
      firstNotNull(uri, this.uri),
      computeIfEmpty(new Option(authorizationCredentials), () => _authorizationCredentials),
      isNotNull(cacheDirectives) ? EMPTY_SET.addAll(cacheDirectives) : _cacheDirectives,
      isNotNull(contentInfo) ? contentInfo : _contentInfo,
      isNotNull(cookies) ? CookieMultimap.EMPTY.putAll(cookies) : _cookies,
      isNotNull(customHeaders) ? EMPTY_DICTIONARY.putAll(customHeaders) : _customHeaders,
      computeIfEmpty(new Option(entity), () => this.entity),
      isNotNull(expectations) ? EMPTY_SET.addAll(expectations) : _expectations,
      isNotNull(pragmaCacheDirectives) ? EMPTY_SET.addAll(pragmaCacheDirectives) : _pragmaCacheDirectives,
      isNotNull(preconditions) ? preconditions : _preconditions,
      isNotNull(preferences) ? preferences : _preferences,
      computeIfEmpty(new Option(proxyAuthorizationCredentials), () => _proxyAuthorizationCredentials),
      computeIfEmpty(new Option(referer), () => _referer),
      computeIfEmpty(new Option(userAgent), () => _userAgent),
      firstNotNull(version, this.version),
      _headers);
  }

  Request without({
    bool authorizationCredentials : false,
    bool cacheDirectives : false,
    bool contentInfo : false,
    bool cookies : false,
    bool customHeaders : false,
    bool entity : false,
    bool expectations : false,
    bool pragmaCacheDirectives : false,
    bool preconditions : false,
    bool preferences : false,
    bool proxyAuthorizationCredentials : false,
    bool referer : false,
    bool userAgent : false}) =>
        new _RequestImpl(
            method, uri,
            authorizationCredentials ? Option.NONE : _authorizationCredentials,
            cacheDirectives ? EMPTY_SET : _cacheDirectives,
            contentInfo ? ContentInfo.NONE : _contentInfo,
            cookies ? CookieMultimap.EMPTY : _cookies,
            customHeaders ? EMPTY_DICTIONARY : _customHeaders,
            entity ? Option.NONE : this.entity,
            expectations? EMPTY_SET : _expectations,
            pragmaCacheDirectives ? EMPTY_SET : _pragmaCacheDirectives,
            preconditions ? RequestPreconditions.NONE : _preconditions,
            preferences ? RequestPreferences.NONE : _preferences,
            proxyAuthorizationCredentials ? Option.NONE : _proxyAuthorizationCredentials,
            referer ? Option.NONE : _referer,
            userAgent ? Option.NONE: _userAgent,
            this.version,
            _headers);
}