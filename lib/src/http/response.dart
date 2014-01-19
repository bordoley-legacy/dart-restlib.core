part of restlib.core.http;

String _responseToString(final Response response) {
    final StringBuffer buffer = 
        (new StringBuffer()
          ..write("${response.status}\r\n")
          ..write(Header.ACCEPT_RANGES.write(response.acceptedRangeUnits))
          ..write(Header.AGE.write(response.age))
          ..write(Header.ALLOW.write(response.allowedMethods))
          ..write(Header.WWW_AUTHENTICATE.write(response.authenticationChallenges))
          ..write(Header.CACHE_CONTROL.write(response.cacheDirectives))
          ..write(response.contentInfo)
          ..write(Header.DATE.write(response.date))
          ..write(Header.ENTITY_TAG.write(response.entityTag))
          ..write(Header.EXPIRES.write(response.expires))
          ..write(Header.LAST_MODIFIED.write(response.lastModified))
          ..write(Header.LOCATION.write(response.location))
          ..write(Header.PROXY_AUTHENTICATE.write(response.proxyAuthenticationChallenges))
          ..write(Header.RETRY_AFTER.write(response.retryAfter))
          ..write(Header.SERVER.write(response.server))
          ..write(Header.VARY.write(response.vary)));
   
  response.customHeaders.forEach((final Pair<Header, dynamic> header) =>
      buffer.write(header.fst.write(header.snd)));      
  
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
  final Uri location,
  final Iterable<ChallengeMessage> proxyAuthenticationChallenges,
  final DateTime retryAfter,
  final UserAgent server,
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
      isNull(status) &&
      isNull(vary) &&
      isNull(warnings)) {
    return delegate;
  }
  
  return new _ResponseImpl(
      Persistent.EMPTY_SET.addAll(firstNotNull(acceptedRangeUnits, delegate.acceptedRangeUnits)),
      computeIfEmpty(new Option(age), () => delegate.age),
      Persistent.EMPTY_SET.addAll(firstNotNull(allowedMethods, delegate.allowedMethods)),
      Persistent.EMPTY_SET.addAll(firstNotNull(authenticationChallenges, delegate.authenticationChallenges)),
      Persistent.EMPTY_SET.addAll(firstNotNull(cacheDirectives, delegate.cacheDirectives)),
      firstNotNull(contentInfo, delegate.contentInfo),
      Persistent.EMPTY_DICTIONARY.insertAll(firstNotNull(customHeaders, delegate.customHeaders)),
      computeIfEmpty(new Option(date), () => delegate.date),
      computeIfEmpty(new Option(entity), () => delegate.entity),
      computeIfEmpty(new Option(entityTag), () => delegate.entityTag),
      computeIfEmpty(new Option(expires), () => delegate.expires),
      computeIfEmpty(new Option(lastModified), () => delegate.lastModified),
      computeIfEmpty(new Option(location), () => delegate.location),
      Persistent.EMPTY_SET.addAll(firstNotNull(proxyAuthenticationChallenges, delegate.proxyAuthenticationChallenges)),   
      computeIfEmpty(new Option(retryAfter), () => delegate.retryAfter),
      computeIfEmpty(new Option(server), () => delegate.server),
      firstNotNull(status, delegate.status),
      Persistent.EMPTY_SET.addAll(firstNotNull(vary, delegate.vary)),
      Persistent.EMPTY_SEQUENCE.addAll(firstNotNull(warnings, delegate.warnings)));
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
  final bool vary,
  final bool warnings) =>
      new _ResponseImpl(
          !acceptedRangeUnits ? Persistent.EMPTY_SET.addAll(delegate.acceptedRangeUnits) : Persistent.EMPTY_SET,
          !age ? delegate.age : Option.NONE, 
          !allowedMethods ? Persistent.EMPTY_SET.addAll(delegate.allowedMethods) : Persistent.EMPTY_SET,
          !authenticationChallenges ? Persistent.EMPTY_SET.addAll(delegate.authenticationChallenges) : Persistent.EMPTY_SET,
          !cacheDirectives ? Persistent.EMPTY_SET.addAll(delegate.authenticationChallenges) : Persistent.EMPTY_SET,
          !contentInfo ? delegate.contentInfo : ContentInfo.NONE,
          !customHeaders ? Persistent.EMPTY_DICTIONARY.insertAll(delegate.customHeaders) : Persistent.EMPTY_DICTIONARY,
          !date ? delegate.date : Option.NONE,
          !entity ? delegate.entity : Option.NONE,
          !entityTag ? delegate.entityTag : Option.NONE,
          !expires ? delegate.expires : Option.NONE,
          !lastModified ? delegate.lastModified : Option.NONE,
          !location ? delegate.location : Option.NONE,    
          !proxyAuthenticationChallenges ? Persistent.EMPTY_SET.addAll(delegate.proxyAuthenticationChallenges) : Persistent.EMPTY_SET,
          !retryAfter ? delegate.retryAfter : Option.NONE,
          !server ? delegate.server : Option.NONE,
          delegate.status,
          !vary ? Persistent.EMPTY_SET.addAll(delegate.vary) : Persistent.EMPTY_SET,
          !warnings ? Persistent.EMPTY_SEQUENCE.addAll(delegate.warnings) :  Persistent.EMPTY_SEQUENCE);
          
abstract class Response<T> {  
  factory Response(
    final Status status, {
    final Iterable<RangeUnit> acceptedRangeUnits : const [],
    final int age,
    final Iterable<Method> allowedMethods : const [],
    final Iterable<ChallengeMessage> authenticationChallenges : const [],
    final Iterable<CacheDirective> cacheDirectives : const [],
    final ContentInfo contentInfo,
    final Dictionary<Header, dynamic> customHeaders : Persistent.EMPTY_DICTIONARY,
    final DateTime date,
    final T entity,
    final EntityTag entityTag,
    final DateTime expires,
    final DateTime lastModified,
    final Uri location,
    final Iterable<ChallengeMessage> proxyAuthenticationChallenges : const [],
    final DateTime retryAfter,
    final UserAgent server,  
    final Iterable<Header> vary : const [],
    final Iterable<Warning> warnings : const []}) =>
        new _ResponseImpl(
            Persistent.EMPTY_SET.addAll(acceptedRangeUnits),
            new Option(age),
            Persistent.EMPTY_SET.addAll(allowedMethods),
            Persistent.EMPTY_SET.addAll(authenticationChallenges),
            Persistent.EMPTY_SET.addAll(cacheDirectives),
            firstNotNull(contentInfo, ContentInfo.NONE),
            Persistent.EMPTY_DICTIONARY.insertAll(customHeaders),
            new Option(date),
            new Option(entity),
            new Option(entityTag),
            new Option(expires),
            new Option(lastModified),
            new Option(location),
            Persistent.EMPTY_SET.addAll(proxyAuthenticationChallenges),
            new Option(retryAfter),
            new Option(server),
            status,
            Persistent.EMPTY_SET.addAll(vary),
            Persistent.EMPTY_SEQUENCE.addAll(warnings));
    
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
  
  Option<Uri> get location;
  
  FiniteSet<ChallengeMessage> get proxyAuthenticationChallenges;
  
  Option<DateTime> get retryAfter;
  
  Option<UserAgent> get server;
  
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
    Uri location,
    Iterable<ChallengeMessage> proxyAuthenticationChallenges,
    DateTime retryAfter,
    UserAgent server,
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
    bool vary : false,
    bool warnings : false});
}

abstract class ForwardingResponse<T> implements Forwarder, Response<T> {
  FiniteSet<RangeUnit> get acceptedRangeUnits =>
      delegate.acceptedRangeUnits;
  
  Option<int> get age =>
      delegate.age;
  
  FiniteSet<Method> get allowedMethods =>
      delegate.allowedMethods;
  
  FiniteSet<ChallengeMessage> get authenticationChallenges =>
      delegate.authenticationChallenges;
  
  FiniteSet<CacheDirective> get cacheDirectives =>
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
  
  FiniteSet<ChallengeMessage> get proxyAuthenticationChallenges =>
      delegate.proxyAuthenticationChallenges;
  
  Option<DateTime> get retryAfter =>
      delegate.retryAfter;
  
  Option<UserAgent> get server =>
      delegate.server;
  
  Status get status =>
      delegate.status;
  
  FiniteSet<Header> get vary =>
      delegate.vary;
  
  Sequence<Warning> get warnings =>
      delegate.warnings;
  
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
    final Uri location,
    final Iterable<ChallengeMessage> proxyAuthenticationChallenges,
    final DateTime retryAfter,
    final UserAgent server,
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
            vary,
            warnings);
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
    final Uri location,
    final Iterable<ChallengeMessage> proxyAuthenticationChallenges,
    final DateTime retryAfter,
    final UserAgent server,
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
  final Option<Uri> location;
  final ImmutableSet<ChallengeMessage> proxyAuthenticationChallenges;
  final Option<DateTime> retryAfter;
  final Option<UserAgent> server;
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
    this.status,
    this.vary,
    this.warnings);
}