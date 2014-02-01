part of restlib.core.http;

String _requestToString(final Request request) {
  final String requestLine = "${request.method} ${request.uri.path}${request.uri.query.isEmpty ? "" : request.uri.query}\r\n";
    
  final StringBuffer buffer = (new StringBuffer()
    ..write(requestLine)
    ..write(Header.HOST.write(request.uri.authority.value))
    ..write(Header.AUTHORIZATION.write(request.authorizationCredentials))
    ..write(Header.CACHE_CONTROL.write(request.cacheDirectives))
    ..write(request.contentInfo)
    ..write(Header.COOKIE.write(request.cookies.toString()))
    ..write(Header.EXPECT.write(request.expectations))
    ..write(Header.PRAGMA.write(request.pragmaCacheDirectives))
    ..write(request.preconditions)
    ..write(request.preferences)
    ..write(Header.PROXY_AUTHORIZATION.write(request.proxyAuthorizationCredentials))
    ..write(Header.REFERER.write(request.referer))
    ..write(Header.USER_AGENT.write(request.userAgent))
    ..write(request.entity.map((final entity) => 
        "\r\n\r\n${entity.toString()}\r\n").orElse("")));
    
  request.customHeaders.forEach((final Pair<Header, dynamic> pair) =>
      buffer.write(pair.fst.write(pair.snd)));
    
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
      Persistent.EMPTY_SET.addAll(firstNotNull(cacheDirectives, delegate.cacheDirectives)),
      firstNotNull(contentInfo, delegate.contentInfo),
      CookieMultimap.EMPTY.putAll(firstNotNull(cookies, delegate.cookies)),
      Persistent.EMPTY_DICTIONARY.putAll(firstNotNull(customHeaders, delegate.customHeaders)),
      computeIfEmpty(new Option(entity), () => delegate.entity),
      Persistent.EMPTY_SET.addAll(firstNotNull(expectations, delegate.expectations)),
      firstNotNull(method, delegate.method),
      Persistent.EMPTY_SET.addAll(firstNotNull(pragmaCacheDirectives, delegate.pragmaCacheDirectives)),
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
          !cacheDirectives ? Persistent.EMPTY_SET.addAll(delegate.cacheDirectives) : Persistent.EMPTY_SET,
          !contentInfo ? delegate.contentInfo : ContentInfo.NONE,
          !cookies ? CookieMultimap.EMPTY.putAll(delegate.cookies) : Persistent.EMPTY_SET,   
          !customHeaders ? Persistent.EMPTY_DICTIONARY.putAll(delegate.customHeaders) : Persistent.EMPTY_DICTIONARY,
          !entity ? delegate.entity : Option.NONE,
          !expectations? Persistent.EMPTY_SET.addAll(delegate.expectations) : Persistent.EMPTY_SET,
          delegate.method,
          !pragmaCacheDirectives ? Persistent.EMPTY_SET.addAll(delegate.pragmaCacheDirectives) : Persistent.EMPTY_SET,
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
            Persistent.EMPTY_SET.addAll(firstNotNull(cacheDirectives, EMPTY_LIST)),
            firstNotNull(contentInfo, ContentInfo.NONE),
            CookieMultimap.EMPTY.putAll(firstNotNull(cookies, EMPTY_LIST)),
            Persistent.EMPTY_DICTIONARY.putAll(firstNotNull(customHeaders, Persistent.EMPTY_DICTIONARY)),
            new Option(entity),
            Persistent.EMPTY_SET.addAll(firstNotNull(expectations, EMPTY_LIST)),
            method,
            Persistent.EMPTY_SET.addAll(firstNotNull(pragmaCacheDirectives, EMPTY_LIST)),
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

abstract class ForwardingRequest<T> implements Forwarder, Request<T> {
  Option<ChallengeMessage> get authorizationCredentials =>
      delegate.authorizationCredentials;
  
  FiniteSet<CacheDirective> get cacheDirectives =>
      delegate.cacheDirectives;
  
  ContentInfo get contentInfo =>
      delegate.contentInfo;
  
  CookieMultimap get cookies =>
      delegate.cookies;
  
  Dictionary<Header, dynamic> get customHeaders =>
      delegate.customHeaders;
  
  Option<T> get entity =>
      delegate.entity;
  
  FiniteSet<Expectation> get expectations =>
      delegate.expectations;
  
  Method get method =>
      delegate.method;
  
  FiniteSet<CacheDirective> get pragmaCacheDirectives =>
      delegate.pragmaCacheDirectives;
  
  RequestPreconditions get preconditions =>
      delegate.preconditions;
  
  RequestPreferences get preferences =>
      delegate.preferences;
  
  Option<ChallengeMessage> get proxyAuthorizationCredentials =>
      delegate.proxyAuthorizationCredentials;
  
  Option<URI> get referer =>
      delegate.referer;
  
  URI get uri =>
      delegate.uri;
  
  Option<UserAgent> get userAgent =>
      delegate.userAgent;
  
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
        _authorizationCredentials = _parse(CHALLENGE_MESSAGE, Header.AUTHORIZATION);
        return _authorizationCredentials;
      });
  
  ImmutableSet<CacheDirective> get cacheDirectives =>
      computeIfNull(_cacheDirectives, () {
        _cacheDirectives = 
            _parse(CACHE_CONTROL, Header.CACHE_CONTROL)
              .map((final Iterable<CacheDirective> cacheDirectives) =>
                  Persistent.EMPTY_SET.addAll(cacheDirectives))
              .orElse(Persistent.EMPTY_SET);
            
        return _cacheDirectives;
      });
  
  ContentInfo get contentInfo =>
      computeIfNull(_contentInfo, () {
        _contentInfo = new ContentInfo.wrapHeaders(_headers);
        return _contentInfo;
      });
  
  CookieMultimap get cookies =>
      computeIfNull(_cookies, () {
        _cookies = _parse(COOKIE, Header.COOKIE).orElse(CookieMultimap.EMPTY);    
        return _cookies;
      });
  
  Dictionary<Header, dynamic> get customHeaders =>
      computeIfNull(_customHeaders, () {
        _customHeaders = 
            _headers.dictionary
              .filterKeys((final Header header) => 
                  !Header._standard.contains(header))
              .mapValues((final Sequence<String> values) => 
                // FIXME: Verify this is correct.
                values.join(","));
        return _customHeaders;
      });
  
  ImmutableSet<Expectation> get expectations =>
      computeIfNull(_expectations, () {
        _expectations = 
            _parse(EXPECT, Header.EXPECT)
              .map((final Iterable<Expectation> expectations) =>
                  Persistent.EMPTY_SET.addAll(expectations))
              .orElse(Persistent.EMPTY_SET);
            
        return _expectations;
      });
  
  ImmutableSet<CacheDirective> get pragmaCacheDirectives =>
      computeIfNull(_pragmaCacheDirectives, () {
        _pragmaCacheDirectives = 
            _parse(PRAGMA, Header.PRAGMA)
              .map((final Iterable<CacheDirective> pragmaCacheDirectives) =>
                  Persistent.EMPTY_SET.addAll(pragmaCacheDirectives))
              .orElse(Persistent.EMPTY_SET);
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
        _proxyAuthorizationCredentials = _parse(CHALLENGE_MESSAGE, Header.PROXY_AUTHORIZATION);
        return _proxyAuthorizationCredentials;
      });

  Option<URI> get referer =>
      computeIfNull(_referer, () {
        _referer = firstWhere(_headers[Header.REFERER], (final String uri) => true)
            .flatMap(URI_.parse);
        return _referer;
      });
  
  Option<UserAgent> get userAgent =>
      computeIfNull(_userAgent, () {
        _userAgent = _parse(USER_AGENT, Header.USER_AGENT);
        return _userAgent;    
      });
}

Request requestMethodOverride(final Request request) {  
  Request updateMethod(final Header header) =>
      TOKEN.parse(request.customHeaders(header).value)
        .map((final String token) {
          final Method method = new Method.forName(token);
          final Dictionary<Header, dynamic> customHeaders =
              Persistent.EMPTY_DICTIONARY
                .putAll(request.customHeaders)
                .removeAt(Header.X_HTTP_METHOD)
                .removeAt(Header.X_HTTP_METHOD_OVERRIDE)
                .removeAt(Header.X_METHOD_OVERRIDE);
          return request.with_(method: method, customHeaders : customHeaders);
        }).orElse(request);
  
  if (request.method != Method.POST) {
    return request;
  } else if (request.customHeaders.containsKey(Header.X_HTTP_METHOD)) {
    return updateMethod(Header.X_HTTP_METHOD);
  } else if (request.customHeaders.containsKey(Header.X_HTTP_METHOD_OVERRIDE)) {
    return updateMethod(Header.X_HTTP_METHOD_OVERRIDE);
  } else if (request.customHeaders.containsKey(Header.X_METHOD_OVERRIDE)) {
    return updateMethod(Header.X_METHOD_OVERRIDE);
  } else {
    return request;
  }
}