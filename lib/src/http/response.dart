part of restlib.core.http;

abstract class Response<T> {  
  ImmutableSet<RangeUnit> get acceptedRangeUnits;
  Option<int> get age;
  ImmutableSet<Method> get allowedMethods;
  ImmutableSet<ChallengeMessage> get authenticationChallenges;
  ImmutableSet<CacheDirective> get cacheDirectives;
  ContentInfo get contentInfo;
  Option<DateTime> get date;
  Option<T> get entity;
  Option<EntityTag> get entityTag;
  Option<DateTime> get expires;
  Option<DateTime> get lastModified;
  Option<Uri> get location;
  ImmutableSet<ChallengeMessage> get proxyAuthenticationChallenges;
  Option<DateTime> get retryAfter;
  Option<UserAgent> get server;
  Status get status;
  ImmutableSet<Header> get vary;
  ImmutableSequence<Warning> get warnings;
  
  Response with_({
    Iterable<RangeUnit> acceptedRangeUnits,
    int age,
    Iterable<Method> allowedMethods,
    Iterable<ChallengeMessage> authenticationChallenges,
    Iterable<CacheDirective> cacheDirectives,
    ContentInfo contentInfo,
    DateTime date,
    entity,
    EntityTag entityTag,
    DateTime expires,
    DateTime lastModified,
    Uri location,
    Iterable<ChallengeMessage> proxyAuthenticationChallenges,
    DateTime retryAfter,
    UserAgent server,
    Status status,
    Iterable<Header> vary,
    Iterable<Warning> warnings});
}

abstract class ForwardingResponse<T> implements Forwarder, Response<T> {
  ImmutableSet<RangeUnit> get acceptedRangeUnits =>
      delegate.acceptedRangeUnits;
  
  Option<int> get age =>
      delegate.age;
  
  ImmutableSet<Method> get allowedMethods =>
      delegate.allowedMethods;
  
  ImmutableSet<ChallengeMessage> get authenticationChallenges =>
      delegate.authenticationChallenges;
  
  ImmutableSet<CacheDirective> get cacheDirectives =>
      delegate.cacheDirectives;
  
  ContentInfo get contentInfo =>
      delegate.contentInfo;
  
  Option<DateTime> get date =>
      delegate.date;
  
  Option<T> get entity =>
      delegate.entity;
  
  Option<EntityTag> get entityTag =>
      delegate.entityTag;
  
  Option<DateTime> get expires =>
      delegate.expires;
  
  Option<DateTime> get lastModified =>
      delegate.lastModified;
  
  Option<Uri> get location =>
      delegate.location;
  
  ImmutableSet<ChallengeMessage> get proxyAuthenticationChallenges =>
      delegate.proxyAuthenticationChallenges;
  
  Option<DateTime> get retryAfter =>
      delegate.retryAfter;
  
  Option<UserAgent> get server =>
      delegate.server;
  
  Status get status =>
      delegate.status;
  
  ImmutableSet<Header> get vary =>
      delegate.vary;
  
  ImmutableSequence<Warning> get warnings =>
      delegate.warnings;
}

abstract class ResponseWith_<T> implements Response<T> {
  Response with_({final Iterable<RangeUnit> acceptedRangeUnits,
                  final int age,
                  final Iterable<Method> allowedMethods,
                  final Iterable<ChallengeMessage> authenticationChallenges,
                  final Iterable<CacheDirective> cacheDirectives,
                  final ContentInfo contentInfo,
                  final DateTime date,
                  final T entity,
                  final EntityTag entityTag,
                  final DateTime expires,
                  final DateTime lastModified,
                  final Uri location,
                  final Iterable<ChallengeMessage> proxyAuthenticationChallenges,
                  final DateTime retryAfter,
                  final UserAgent server,
                  final Status status,
                  final Iterable<Header> vary,
                  final Iterable<Warning> warnings}) => 
    new _ResponseImpl._delegating(this, 
        acceptedRangeUnits: acceptedRangeUnits, 
        age: age, 
        allowedMethods: allowedMethods, 
        authenticationChallenges: authenticationChallenges,
        cacheDirectives: cacheDirectives, 
        contentInfo: contentInfo, 
        date: date, 
        entity: entity, 
        entityTag: entityTag, 
        expires: expires, 
        lastModified: lastModified, 
        location: location, 
        proxyAuthenticationChallenges: proxyAuthenticationChallenges, 
        retryAfter: retryAfter, 
        server: server, 
        status: status, 
        vary: vary, 
        warnings: warnings);
}

abstract class ResponseToString<T> implements Response<T> {
  String toString() {
    return (new StringBuffer()
            ..write("$status\r\n")
            ..write(Header.ACCEPT_RANGES.write(acceptedRangeUnits))
            ..write(Header.AGE.write(age))
            ..write(Header.ALLOW.write(allowedMethods))
            ..write(Header.WWW_AUTHENTICATE.write(authenticationChallenges))
            ..write(Header.CACHE_CONTROL.write(cacheDirectives))
            ..write(contentInfo)
            ..write(Header.DATE.write(date))
            ..write(Header.ENTITY_TAG.write(entityTag))
            ..write(Header.EXPIRES.write(expires))
            ..write(Header.LAST_MODIFIED.write(lastModified))
            ..write(Header.LOCATION.write(location))
            ..write(Header.PROXY_AUTHENTICATE.write(proxyAuthenticationChallenges))
            ..write(Header.RETRY_AFTER.write(retryAfter))
            ..write(Header.SERVER.write(server))
            ..write(Header.VARY.write(vary))
            ..write(entity.map((final entity) => 
                "\r\n\r\n${entity.toString()}\r\n").orElse(""))
            ).toString();    
  }
}

class ResponseBuilder<T> {
  MutableSet<RangeUnit> _acceptedRangeUnits = new MutableSet.hash();
  Option<int> _age = Option.NONE;
  MutableSet<Method> _allowedMethods = new MutableSet.hash();
  MutableSet<ChallengeMessage> _authenticationChallenges = new MutableSet.hash();
  MutableSet<CacheDirective> _cacheDirectives = new MutableSet.hash();
  ContentInfo _contentInfo = ContentInfo.NONE;
  Option<DateTime> _date = Option.NONE;
  Option<T> _entity = Option.NONE;
  Option<EntityTag> _entityTag = Option.NONE;
  Option<DateTime> _expires = Option.NONE;
  Option<DateTime> _lastModified = Option.NONE;
  Option<Uri> _location = Option.NONE;
  MutableSet<ChallengeMessage> _proxyAuthenticationChallenges = new MutableSet.hash();
  Option<DateTime> _retryAfter = Option.NONE;
  Option<UserAgent> _server = Option.NONE;
  Status _status = Status.SUCCESS_OK;
  MutableSet<Header> _vary = new MutableSet.hash();
  MutableSequence<Warning> _warnings = new GrowableSequence();

  set age(final int age) => 
      this._age = new Option(age);
  
  set contentInfo(final ContentInfo contentInfo) => 
      this._contentInfo = checkNotNull(contentInfo);

  set date(final DateTime date) => 
      this._date = new Option(date);

  set entity(final T entity) => 
      this._entity = new Option(entity);
  
  set entityTag(final EntityTag entity) => 
      this._entityTag = new Option(entity);
  
  set expires(final DateTime date) => 
      this._expires = new Option(date);
  
  set lastModified(final DateTime date) => 
      this._lastModified = new Option(date);
  
  set location(final Uri location) =>
      this._location = new Option(location);
  
  set retryAfter(final DateTime date) => 
      this._retryAfter = new Option(date);

  set server(final UserAgent server) => 
      this._server = new Option(server);
  
  set status(final Status status) => 
      this._status = checkNotNull(status);
  
  void addAllowedMethod(final Method method) =>
      this._allowedMethods.add(method);
  
  void addAllowedMethods(final Iterable<Method> methods) =>
      this._allowedMethods.addAll(methods);
  
  void addAcceptedRangeUnit(final RangeUnit rangeUnit) =>
      this._acceptedRangeUnits.add(rangeUnit);
  
  void addAcceptedRangeUnits(final Iterable<RangeUnit> rangeUnits) =>
      this._acceptedRangeUnits.addAll(rangeUnits);
  
  void addAuthenticationChallenge(final ChallengeMessage challengeMessage) =>
      this._authenticationChallenges.add(challengeMessage);
  
  void addAuthenticationChallenges(final Iterable<ChallengeMessage> challengeMessages) =>
      this._authenticationChallenges.addAll(challengeMessages);
  
  void addCacheDirective(final CacheDirective cacheDirective) =>
      this._cacheDirectives.add(cacheDirective);
  
  void addCacheDirectives(final Iterable<CacheDirective> cacheDirectives) =>
      this._cacheDirectives.addAll(cacheDirectives);
  
  void addProxyAuthenticationChallenge(final ChallengeMessage challenge) =>
      this._proxyAuthenticationChallenges.add(challenge); 
  
  void addProxyAuthenticationChallenges(final Iterable<ChallengeMessage> challenges) =>
      this._proxyAuthenticationChallenges.addAll(challenges); 
  
  void addVaryHeader(final Header header) =>
      this._vary.add(header);

  void addVaryHeaders(final Iterable<Header> headers) => 
      this._vary.addAll(headers);
  
  void addWarning(final Warning warning) => 
      this._warnings.add(warning);
  
  void addWarnings(final Iterable<Warning> warnings) => 
      this._warnings.addAll(warnings);

  Response<T> build() => 
      new _ResponseImpl(this);
}

class _ResponseImpl<T> 
    extends Object 
    with ResponseToString<T>,
      ResponseWith_<T>
     implements Response<T> {
  final ImmutableSet<RangeUnit> acceptedRangeUnits;
  final Option<int> age;
  final ImmutableSet<Method> allowedMethods;
  final ImmutableSet<ChallengeMessage> authenticationChallenges;
  final ImmutableSet<CacheDirective> cacheDirectives;
  final ContentInfo contentInfo;
  final Option<DateTime> date;
  final Option<T> entity;
  final Option<EntityTag> entityTag;
  final Option<DateTime> expires;
  final Option<DateTime> lastModified;
  final Option<Uri> location;
  final ImmutableSet<ChallengeMessage> proxyAuthenticationChallenges;
  final Option<DateTime> retryAfter;
  final Option<UserAgent> server;
  final Status status;
  final ImmutableSet<Header> vary;
  final ImmutableSequence<Warning> warnings;

  _ResponseImpl(final ResponseBuilder builder):
    acceptedRangeUnits = Persistent.EMPTY_SET.addAll(builder._acceptedRangeUnits),
    age = builder._age,
    allowedMethods = Persistent.EMPTY_SET.addAll(builder._allowedMethods),
    authenticationChallenges = Persistent.EMPTY_SET.addAll(builder._authenticationChallenges),
    cacheDirectives = Persistent.EMPTY_SET.addAll(builder._cacheDirectives),
    contentInfo = builder._contentInfo,
    date = builder._date,
    entity = builder._entity,
    entityTag = builder._entityTag,
    expires = builder._expires,
    lastModified = builder._lastModified,
    location = builder._location,
    proxyAuthenticationChallenges = Persistent.EMPTY_SET.addAll(builder._proxyAuthenticationChallenges),
    retryAfter = builder._retryAfter,
    server = builder._server,
    status = builder._status,
    vary = Persistent.EMPTY_SET.addAll(builder._vary),
    warnings = Persistent.EMPTY_SEQUENCE.addAll(builder._warnings);
  
  _ResponseImpl._delegating(final Response delegate,
                            {final Iterable<RangeUnit> acceptedRangeUnits,
                             final int age,
                             final Iterable<Method> allowedMethods,
                             final Iterable<ChallengeMessage> authenticationChallenges,
                             final Iterable<CacheDirective> cacheDirectives,
                             final ContentInfo contentInfo,
                             final DateTime date,
                             final entity,
                             final EntityTag entityTag,
                             final DateTime expires,
                             final DateTime lastModified,
                             final Uri location,
                             final Iterable<ChallengeMessage> proxyAuthenticationChallenges,
                             final DateTime retryAfter,
                             final UserAgent server,
                             final Status status,
                             final Iterable<Header> vary,
                             final Iterable<Warning> warnings}) :
    this.acceptedRangeUnits = computeIfNotNullOtherwise(acceptedRangeUnits, delegate.acceptedRangeUnits, Persistent.EMPTY_SET.addAll),
    this.age = computeIfEmpty(new Option(age), () => delegate.age),
    this.allowedMethods = computeIfNotNullOtherwise(allowedMethods, delegate.allowedMethods, Persistent.EMPTY_SET.addAll),
    this.authenticationChallenges = computeIfNotNullOtherwise(authenticationChallenges, delegate.authenticationChallenges, Persistent.EMPTY_SET.addAll),
    this.cacheDirectives = computeIfNotNullOtherwise(authenticationChallenges, delegate.authenticationChallenges, Persistent.EMPTY_SET.addAll),
    this.contentInfo = firstNotNull(contentInfo, delegate.contentInfo),
    this.date = computeIfEmpty(new Option(date), () => delegate.date),
    this.entity = computeIfEmpty(new Option(entity), () => delegate.entity),
    this.entityTag = computeIfEmpty(new Option(entityTag), () => delegate.entityTag),
    this.expires = computeIfEmpty(new Option(expires), () => delegate.expires),
    this.lastModified = computeIfEmpty(new Option(lastModified), () => delegate.lastModified),
    this.location = computeIfEmpty(new Option(location), () => delegate.location),
    this.proxyAuthenticationChallenges = computeIfNotNullOtherwise(proxyAuthenticationChallenges, delegate.proxyAuthenticationChallenges, Persistent.EMPTY_SET.addAll),
    this.retryAfter = computeIfEmpty(new Option(retryAfter), () => delegate.retryAfter),
    this.server = computeIfEmpty(new Option(server), () => delegate.server),
    this.status = firstNotNull(status, delegate.status),
    this.vary = computeIfNotNullOtherwise(vary, delegate.vary, Persistent.EMPTY_SET.addAll),
    this.warnings = computeIfNotNullOtherwise(warnings, delegate.warnings, Persistent.EMPTY_SET.addAll);
}