part of restlib.core.http;

abstract class Request<T> {  
  Option<ChallengeMessage> get authorizationCredentials;
  ImmutableSet<CacheDirective> get cacheDirectives;
  ContentInfo get contentInfo;
  Option<T> get entity;
  ImmutableSet<Expectation> get expectations;
  Method get method;
  ImmutableSet<CacheDirective> get pragmaCacheDirectives;
  RequestPreconditions get preconditions;
  RequestPreferences get preferences;
  Option<ChallengeMessage> get proxyAuthorizationCredentials;
  Option<Uri> get referer;
  Uri get uri;
  Option<UserAgent> get userAgent;
  
  Request with_({
    ChallengeMessage authorizationCredentials,
    Iterable<CacheDirective> cacheDirectives,
    ContentInfo contentInfo,
    entity,
    Iterable<Expectation> expectations,
    Method method,
    Iterable<CacheDirective> pragmaCacheDirectives,
    RequestPreconditions preconditions,
    RequestPreferences preferences,
    ChallengeMessage proxyAuthorizationCredentials,
    Uri referer,
    Uri uri,
    UserAgent userAgent});
}

abstract class ForwardingRequest<T> implements Forwarder, Request<T> {
  Option<ChallengeMessage> get authorizationCredentials =>
      delegate.authorizationCredentials;
  
  ImmutableSet<CacheDirective> get cacheDirectives =>
      delegate.cacheDirectives;
  
  ContentInfo get contentInfo =>
      delegate.contentInfo;
  
  Option<T> get entity =>
      delegate.entity;
  
  ImmutableSet<Expectation> get expectations =>
      delegate.expectations;
  
  Method get method =>
      delegate.method;
  
  ImmutableSet<CacheDirective> get pragmaCacheDirectives =>
      delegate.pragmaCacheDirectives;
  
  RequestPreconditions get preconditions =>
      delegate.preconditions;
  
  RequestPreferences get preferences =>
      delegate.preferences;
  
  Option<ChallengeMessage> get proxyAuthorizationCredentials =>
      delegate.proxyAuthorizationCredentials;
  
  Option<Uri> get referer =>
      delegate.referer;
  
  Uri get uri =>
      delegate.uri;
  
  Option<UserAgent> get userAgent =>
      delegate.userAgent;
}

abstract class RequestWith_ implements Request {
  Request with_({
    final ChallengeMessage authorizationCredentials,
    final Iterable<CacheDirective> cacheDirectives,
    final ContentInfo contentInfo,
    final entity,
    final Iterable<Expectation> expectations,
    final Method method,
    final Iterable<CacheDirective> pragmaCacheDirectives,
    final RequestPreconditions preconditions,
    final RequestPreferences preferences,
    final ChallengeMessage proxyAuthorizationCredentials,
    final Uri referer,
    final Uri uri,
    final UserAgent userAgent}) =>
        new _RequestImpl._delegate(this, 
            authorizationCredentials: authorizationCredentials, 
            cacheDirectives: cacheDirectives, 
            contentInfo: contentInfo, 
            entity: entity, 
            expectations: expectations, 
            method: method, 
            pragmaCacheDirectives: pragmaCacheDirectives, 
            preconditions: preconditions, 
            preferences: preferences, 
            proxyAuthorizationCredentials: proxyAuthorizationCredentials, 
            referer: referer,
            uri: uri, 
            userAgent: userAgent);
}

abstract class RequestToString implements Request {    
  String toString() {
    String requestLine = "${method} ${uri.path}${uri.query.isEmpty ? "" : uri.query}\r\n";
    String host = "${uri.host}${uri.port > 0 ? ":${uri.port}" : ""}";
    
    return (new StringBuffer()
      ..write(requestLine)
      ..write(Header.HOST.write(host))
      ..write(Header.AUTHORIZATION.write(authorizationCredentials))
      ..write(Header.CACHE_CONTROL.write(this.cacheDirectives))
      ..write(contentInfo)
      ..write(Header.EXPECT.write(expectations))
      ..write(Header.PRAGMA.write(pragmaCacheDirectives))
      ..write(preconditions)
      ..write(preferences)
      ..write(Header.PROXY_AUTHORIZATION.write(proxyAuthorizationCredentials))
      ..write(Header.REFERER.write(referer))
      ..write(Header.USER_AGENT.write(userAgent))
      ..write(entity.map((final entity) => 
          "\r\n\r\n${entity.toString()}\r\n").orElse(""))
    ).toString();
  }
}

class RequestBuilder<T> {
  Option<ChallengeMessage> _authorizationCredentials = Option.NONE;
  MutableSet<CacheDirective> _cacheDirectives = new MutableSet.hash();
  ContentInfo _contentInfo = ContentInfo.NONE;
  Option<T> _entity = Option.NONE;
  MutableSet<Expectation> _expectations = new MutableSet.hash();
  Method _method = null;
  MutableSet<CacheDirective> _pragmaCacheDirectives = new MutableSet.hash();
  RequestPreconditions _preconditions = RequestPreconditions.NONE;
  RequestPreferences _preferences = RequestPreferences.NONE;
  Option<ChallengeMessage> _proxyAuthorizationCredentials = Option.NONE;
  Option<Uri> _referer = Option.NONE;
  Uri _uri = null;
  Option<UserAgent> _userAgent = Option.NONE;
  
  set authorizationCredentials(final ChallengeMessage authorizationCredentials) =>
    this._authorizationCredentials = new Option(authorizationCredentials);
  
  set contentInfo(final ContentInfo contentInfo) => 
      this._contentInfo = checkNotNull(contentInfo);
  
  set entity(final T entity) => 
      this._entity = new Option(entity);
  
  set method(final Method method) => 
      this._method = checkNotNull(method);
  
  set preconditions(final RequestPreconditions preconditions) => 
      this._preconditions = checkNotNull(preconditions);
  
  set preferences(final RequestPreferences preferences) =>
      this._preferences = checkNotNull(preferences);
  
  set proxyAuthorizationCredentials(final ChallengeMessage proxyAuthorizationCredentials) =>
      this._proxyAuthorizationCredentials = new Option(proxyAuthorizationCredentials);
  
  set referer(final Uri referer) => 
      this._referer = new Option(referer);
  
  set uri(final Uri uri) => 
      this._uri = checkNotNull(uri);
  
  set userAgent(final UserAgent userAgent) => 
      this._userAgent = new Option(userAgent);
  
  void addCacheDirective(final CacheDirective cacheDirective) {
    this._cacheDirectives.add(cacheDirective);
  }
  
  void addCacheDirectives(final Iterable<CacheDirective> cacheDirectives) => 
      this._cacheDirectives.addAll(cacheDirectives);
  
  void addExpectation(final Expectation expectation) {
    this._expectations.add(expectation);
  }
  
  void addExpectations(final Iterable<Expectation> expectations) => 
      this._expectations.addAll(expectations);
  
  void addPragmaCacheDirective(final CacheDirective cacheDirective) {
    this._pragmaCacheDirectives.add(cacheDirective);
  }
  
  void addPragmaCacheDirectives(final Iterable<CacheDirective> cacheDirectives) => 
      this._pragmaCacheDirectives.addAll(cacheDirectives);
 
  Request build() {
    checkState(_method != null);
    checkState(_uri != null);
    return new _RequestImpl(this); 
  }
}

class _RequestImpl<T> 
    extends Object 
    with RequestToString, 
      RequestWith_
    implements Request {
  final Option<ChallengeMessage> authorizationCredentials;
  final ImmutableSet<CacheDirective> cacheDirectives;
  final ContentInfo contentInfo;
  final Option<T> entity;
  final ImmutableSet<Expectation> expectations;
  final Method method;
  final ImmutableSet<CacheDirective> pragmaCacheDirectives;
  final RequestPreconditions preconditions;
  final RequestPreferences preferences;
  final Option<ChallengeMessage> proxyAuthorizationCredentials;
  final Option<Uri> referer;
  final Uri uri;
  final Option<UserAgent> userAgent;
  
  _RequestImpl(RequestBuilder builder) :
    this.authorizationCredentials = builder._authorizationCredentials,
    this.cacheDirectives = Persistent.EMPTY_SET.addAll(builder._cacheDirectives),
    this.contentInfo = builder._contentInfo,
    this.entity = builder._entity,
    this.expectations = Persistent.EMPTY_SET.addAll(builder._expectations),
    this.method = builder._method,
    this.pragmaCacheDirectives = Persistent.EMPTY_SET.addAll(builder._pragmaCacheDirectives),
    this.preconditions = builder._preconditions,
    this.preferences = builder._preferences,
    this.proxyAuthorizationCredentials = builder._proxyAuthorizationCredentials,
    this.referer = builder._referer,
    this.uri = builder._uri,
    this.userAgent = builder._userAgent;
  
  _RequestImpl._delegate(final Request delegate, {
    final ChallengeMessage authorizationCredentials,
    final Iterable<CacheDirective> cacheDirectives,
    final ContentInfo contentInfo,
    final entity,
    final Iterable<Expectation> expectations,
    final Method method,
    final Iterable<CacheDirective> pragmaCacheDirectives,
    final RequestPreconditions preconditions,
    final RequestPreferences preferences,
    final ChallengeMessage proxyAuthorizationCredentials,
    final Uri referer,
    final Uri uri,
    final UserAgent userAgent}) :
      this.authorizationCredentials = computeIfEmpty(new Option(authorizationCredentials), () => delegate.authorizationCredentials),
      this.cacheDirectives = computeIfNotNullOtherwise(cacheDirectives, delegate.cacheDirectives, Persistent.EMPTY_SET.addAll),
      this.contentInfo = firstNotNull(contentInfo, delegate.contentInfo),
      this.entity = computeIfEmpty(new Option(entity), () => delegate.entity),
      this.expectations = computeIfNotNullOtherwise(expectations, delegate.expectations, Persistent.EMPTY_SET.addAll),
      this.method = firstNotNull(method, delegate.method),
      this.pragmaCacheDirectives = computeIfNotNullOtherwise(pragmaCacheDirectives, delegate.pragmaCacheDirectives, Persistent.EMPTY_SET.addAll),
      this.preconditions = firstNotNull(preconditions, delegate.preconditions),
      this.preferences = firstNotNull(preferences, delegate.preferences),
      this.proxyAuthorizationCredentials = computeIfEmpty(new Option(proxyAuthorizationCredentials), () => delegate.proxyAuthorizationCredentials),
      this.referer = computeIfEmpty(new Option(referer), () => delegate.referer),
      this.uri = firstNotNull(uri, delegate.uri),
      this.userAgent = computeIfEmpty(new Option(userAgent), () => delegate.userAgent);
      
}

