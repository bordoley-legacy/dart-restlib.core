part of http;

void writeRequestHeaders(final Request request, void writeHeaderLine(final String header, final String value)) {
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

String _requestToString(final Request request) {
  final StringBuffer buffer = new StringBuffer();

  _WriteHeaderLine writeHeaderLine = _writeHeaderToBuffer(buffer);

  final String requestLine = "${request.method} ${request.uri.path}${request.uri.query.isEmpty ? "" : "?${request.uri.query}"}""\r\n";
  buffer.write(requestLine);

  writeRequestHeaders(request, writeHeaderLine);

  buffer.write(request.entity.map((final entity) =>
      "\r\n\r\n${entity.toString()}\r\n").orElse(""));

  return buffer.toString();
}

Request _requestWith(
    final Request delegate,
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
    final UserAgent userAgent) {
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
      isNull(userAgent)) {
    return delegate;
  }

  return new _RequestImpl(
      computeIfEmpty(new Option(authorizationCredentials), () => delegate.authorizationCredentials),
      EMPTY_SET.addAll(firstNotNull(cacheDirectives, delegate.cacheDirectives)),
      firstNotNull(contentInfo, delegate.contentInfo),
      CookieMultimap.EMPTY.putAll(firstNotNull(cookies, delegate.cookies)),
      EMPTY_DICTIONARY.putAll(firstNotNull(customHeaders, delegate.customHeaders)),
      computeIfEmpty(new Option(entity), () => delegate.entity),
      EMPTY_SET.addAll(firstNotNull(expectations, delegate.expectations)),
      firstNotNull(method, delegate.method),
      EMPTY_SET.addAll(firstNotNull(pragmaCacheDirectives, delegate.pragmaCacheDirectives)),
      firstNotNull(preconditions, delegate.preconditions),
      firstNotNull(preferences, delegate.preferences),
      computeIfEmpty(new Option(proxyAuthorizationCredentials), () => delegate.proxyAuthorizationCredentials),
      computeIfEmpty(new Option(referer), () => delegate.referer),
      firstNotNull(uri, delegate.uri),
      computeIfEmpty(new Option(userAgent), () => delegate.userAgent));
}

Request _requestWithout(
  final Request delegate,
  final bool authorizationCredentials,
  final bool cacheDirectives,
  final bool contentInfo,
  final bool cookies,
  final bool customHeaders,
  final bool entity,
  final bool expectations,
  final bool pragmaCacheDirectives,
  final bool preconditions,
  final bool preferences,
  final bool proxyAuthorizationCredentials,
  final bool referer,
  final bool userAgent) =>
      new _RequestImpl(
          !authorizationCredentials ? delegate.authorizationCredentials : Option.NONE,
          !cacheDirectives ? EMPTY_SET.addAll(delegate.cacheDirectives) : EMPTY_SET,
          !contentInfo ? delegate.contentInfo : ContentInfo.NONE,
          !cookies ? CookieMultimap.EMPTY.putAll(delegate.cookies) : EMPTY_SET,
          !customHeaders ? EMPTY_DICTIONARY.putAll(delegate.customHeaders) : EMPTY_DICTIONARY,
          !entity ? delegate.entity : Option.NONE,
          !expectations? EMPTY_SET.addAll(delegate.expectations) : EMPTY_SET,
          delegate.method,
          !pragmaCacheDirectives ? EMPTY_SET.addAll(delegate.pragmaCacheDirectives) : EMPTY_SET,
          !preconditions ? delegate.preconditions : RequestPreconditions.NONE,
          !preferences ? delegate.preferences : RequestPreferences.NONE,
          !proxyAuthorizationCredentials ? delegate.proxyAuthorizationCredentials : Option.NONE,
          !referer ? delegate.referer : Option.NONE,
          delegate.uri,
          !userAgent ? delegate.userAgent : Option.NONE);

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
    final UserAgent userAgent}) =>
        new _RequestImpl(
            new Option(authorizationCredentials),
            EMPTY_SET.addAll(firstNotNull(cacheDirectives, EMPTY_LIST)),
            firstNotNull(contentInfo, ContentInfo.NONE),
            CookieMultimap.EMPTY.putAll(firstNotNull(cookies, EMPTY_LIST)),
            EMPTY_DICTIONARY.putAll(firstNotNull(customHeaders, EMPTY_DICTIONARY)),
            new Option(entity),
            EMPTY_SET.addAll(firstNotNull(expectations, EMPTY_LIST)),
            method,
            EMPTY_SET.addAll(firstNotNull(pragmaCacheDirectives, EMPTY_LIST)),
            firstNotNull(preconditions, RequestPreconditions.NONE),
            firstNotNull(preferences, RequestPreferences.NONE),
            new Option(proxyAuthorizationCredentials),
            new Option(referer),
            uri,
            new Option(userAgent));

  factory Request.wrapHeaders(final Method method, final URI uri, final Multimap<Header, String, dynamic> headers) =>
      new _HeadersRequestWrapper(headers, method, uri);

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
    UserAgent userAgent});

  Request without({
    bool authorizationCredentials : false,
    bool cacheDirectives : false,
    bool contentInfo : false,
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

abstract class _RequestMixin<T> implements Request<T> {
  String toString() =>
      _requestToString(this);

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
    final UserAgent userAgent}) =>
        _requestWith(
            this,
            authorizationCredentials,
            cacheDirectives,
            contentInfo,
            cookies,
            customHeaders,
            entity,
            expectations,
            method,
            pragmaCacheDirectives,
            preconditions,
            preferences,
            proxyAuthorizationCredentials,
            referer,
            uri,
            userAgent);

  Request without({
    final bool authorizationCredentials : false,
    final bool cacheDirectives : false,
    final bool contentInfo : false,
    final bool cookies : false,
    final bool customHeaders : false,
    final bool entity : false,
    final bool expectations : false,
    final bool pragmaCacheDirectives : false,
    final bool preconditions : false,
    final bool preferences : false,
    final bool proxyAuthorizationCredentials : false,
    final bool referer : false,
    final bool userAgent : false}) =>
        _requestWithout(
            this,
            authorizationCredentials,
            cacheDirectives,
            contentInfo,
            cookies,
            customHeaders,
            entity,
            expectations,
            pragmaCacheDirectives,
            preconditions,
            preferences,
            proxyAuthorizationCredentials,
            referer,
            userAgent);
}

class _RequestImpl<T>
    extends Object
    with _RequestMixin
    implements Request {
  final Option<ChallengeMessage> authorizationCredentials;
  final ImmutableSet<CacheDirective> cacheDirectives;
  final ContentInfo contentInfo;
  final CookieMultimap cookies;
  final ImmutableDictionary<Header, dynamic> customHeaders;
  final Option<T> entity;
  final ImmutableSet<Expectation> expectations;
  final Method method;
  final ImmutableSet<CacheDirective> pragmaCacheDirectives;
  final RequestPreconditions preconditions;
  final RequestPreferences preferences;
  final Option<ChallengeMessage> proxyAuthorizationCredentials;
  final Option<URI> referer;
  final URI uri;
  final Option<UserAgent> userAgent;

  _RequestImpl(
    this.authorizationCredentials,
    this.cacheDirectives,
    this.contentInfo,
    this.cookies,
    this.customHeaders,
    this.entity,
    this.expectations,
    this.method,
    this.pragmaCacheDirectives,
    this.preconditions,
    this.preferences,
    this.proxyAuthorizationCredentials,
    this.referer,
    this.uri,
    this.userAgent);
}

class _HeadersRequestWrapper
    extends Object
    with _RequestMixin,
      _Parseable
    implements Request {
  Option<ChallengeMessage> _authorizationCredentials;
  ImmutableSet<CacheDirective> _cacheDirectives;
  ContentInfo _contentInfo;
  CookieMultimap _cookies;
  Dictionary<Header, dynamic> _customHeaders;
  final Option entity = Option.NONE;
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

  _HeadersRequestWrapper(this._headers, this.method, this.uri);

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
}