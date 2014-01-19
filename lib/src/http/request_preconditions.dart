part of restlib.core.http;

String _requestPreconditionsToString(final RequestPreconditions delegate) =>
    (new StringBuffer()
      ..write(Header.IF_MATCH.write(delegate.ifMatch))
      ..write(Header.IF_MODIFIED_SINCE.write(delegate.ifModifiedSince))
      ..write(Header.IF_NONE_MATCH.write(delegate.ifNoneMatch))
      ..write(Header.IF_RANGE.write(
          delegate.ifRange.map(
              (final Either<EntityTag, DateTime> ifRange) =>
                    ifRange.value)))
      ..write(Header.IF_UNMODIFIED_SINCE.write(delegate.ifUnmodifiedSince))
    ).toString();

RequestPreconditions _requestPreconditionsWith(
  final RequestPreconditions delegate,
  final Iterable<EntityTag> ifMatch,
  final DateTime ifModifiedSince,
  final Iterable<EntityTag> ifNoneMatch,
  final Either<EntityTag,DateTime> ifRange,
  final DateTime ifUnmodifiedSince) {
  
  if (isNull(ifMatch) && isNull(ifModifiedSince) && isNull(ifNoneMatch) && isNull(ifRange) && isNull(ifUnmodifiedSince)) {
    return delegate;
  }
  
  return new _RequestPreconditionsImpl(
      Persistent.EMPTY_SET.addAll(firstNotNull(ifMatch, delegate.ifMatch)),
      computeIfEmpty(new Option(ifModifiedSince), () => delegate.ifModifiedSince),
      Persistent.EMPTY_SET.addAll(firstNotNull(ifNoneMatch, delegate.ifNoneMatch)),
      computeIfEmpty(new Option(ifRange), () => delegate.ifRange),
      computeIfEmpty(new Option(ifUnmodifiedSince), () => delegate.ifUnmodifiedSince));
}

RequestPreconditions _requestPreconditionsWithout(
  final RequestPreconditions delegate,                                                
  final bool ifMatch,
  final bool ifModifiedSince,
  final bool ifNoneMatch,
  final bool ifRange,
  final bool ifUnmodifiedSince) {
  
  if (ifMatch && ifModifiedSince && ifNoneMatch && ifRange && ifUnmodifiedSince) {
    return RequestPreconditions.NONE;
  }
  
  return new _RequestPreconditionsImpl(
      !ifMatch ? Persistent.EMPTY_SET.addAll(delegate.ifMatch) : Persistent.EMPTY_SET,
      !ifModifiedSince ? delegate.ifModifiedSince : Option.NONE,
      !ifNoneMatch ? Persistent.EMPTY_SET.addAll(delegate.ifNoneMatch) : Persistent.EMPTY_SET,
      !ifRange ? delegate.ifRange : Option.NONE,
      !ifUnmodifiedSince ? delegate.ifModifiedSince : Option.NONE);
}


abstract class RequestPreconditions {
  static const RequestPreconditions NONE = const _RequestPreconditionsNone();
  
  factory RequestPreconditions({
    final Iterable<EntityTag> ifMatch : const [],
    final DateTime ifModifiedSince,
    final Iterable<EntityTag> ifNoneMatch : const [],
    final Either<EntityTag,DateTime> ifRange,
    final DateTime ifUnmodifiedSince}) {
    
    if (isNull(ifMatch) && isNull(ifModifiedSince) && isNull(ifNoneMatch) && isNull(ifRange) && isNull(ifUnmodifiedSince)) {
      return RequestPreconditions.NONE;
    }

    return new _RequestPreconditionsImpl(
        Persistent.EMPTY_SET.addAll(ifMatch), 
        new Option(ifModifiedSince), 
        Persistent.EMPTY_SET.addAll(ifNoneMatch), 
        new Option(ifRange), 
        new Option(ifUnmodifiedSince));   
  }
  
  factory RequestPreconditions.wrapHeaders(final Multimap<Header, String, dynamic> headers) =>
      new _HeadersRequestPreconditionsImpl(headers);
  
  FiniteSet<EntityTag> get ifMatch;
 
  Option<DateTime> get ifModifiedSince;
  
  FiniteSet<EntityTag> get ifNoneMatch;
  
  Option<Either<EntityTag,DateTime>> get ifRange;
  
  Option<DateTime> get ifUnmodifiedSince;
  
  String toString();
  
  RequestPreconditions with_({
    Iterable<EntityTag> ifMatch : const [],
    DateTime ifModifiedSince,
    Iterable<EntityTag> ifNoneMatch : const [],
    Either<EntityTag,DateTime> ifRange,
    DateTime ifUnmodifiedSince}); 
  
  RequestPreconditions without({
    bool ifMatch : false,
    bool ifModifiedSince : false,
    bool ifNoneMatch : false,
    bool ifRange : false,
    bool ifUnmodifiedSince : false}); 
}

class _RequestPreconditionsNone implements RequestPreconditions {
  final ImmutableSet<EntityTag> ifMatch = Persistent.EMPTY_SET;
  final Option<DateTime> ifModifiedSince = Option.NONE;
  final ImmutableSet<EntityTag> ifNoneMatch = Persistent.EMPTY_SET;
  final Option<Either<EntityTag,DateTime>> ifRange = Option.NONE;
  final Option<DateTime> ifUnmodifiedSince = Option.NONE;
  
  const _RequestPreconditionsNone();
  
  String toString() => "";
  
  RequestPreconditions with_({
    final Iterable<EntityTag> ifMatch : const[],
    final DateTime ifModifiedSince,
    final Iterable<EntityTag> ifNoneMatch : const[],
    final Either<EntityTag,DateTime> ifRange,
    final DateTime ifUnmodifiedSince}) =>
        new RequestPreconditions(
            ifMatch: ifMatch, 
            ifModifiedSince : ifModifiedSince, 
            ifNoneMatch: ifNoneMatch, 
            ifRange : ifRange, 
            ifUnmodifiedSince : ifUnmodifiedSince);
  
  RequestPreconditions without({
    bool ifMatch : false,
    bool ifModifiedSince : false,
    bool ifNoneMatch : false,
    bool ifRange : false,
    bool ifUnmodifiedSince : false}) =>
        this;
}

abstract class ForwardingRequestPreconditions implements Forwarder, RequestPreconditions {
  FiniteSet<EntityTag> get ifMatch =>
      delegate.ifMatch;
  
  Option<DateTime> get ifModifiedSince =>
      delegate.ifModifiedSince;
  
  FiniteSet<EntityTag> get ifNoneMatch =>
      delegate.ifNoneMatch;
  
  Option<Either<EntityTag,DateTime>> get ifRange =>
      delegate.ifRange;
  
  Option<DateTime> get ifUnmodifiedSince =>
      delegate.ifUnmodifiedSince;
  
  String toString() =>
      _requestPreconditionsToString(this);
  
  RequestPreconditions with_({
    final Iterable<EntityTag> ifMatch : const [],
    final DateTime ifModifiedSince,
    final Iterable<EntityTag> ifNoneMatch : const [],
    final Either<EntityTag,DateTime> ifRange,
    final DateTime ifUnmodifiedSince}) =>
        _requestPreconditionsWith(
            this,
            ifMatch,
            ifModifiedSince,
            ifNoneMatch,
            ifRange,
            ifUnmodifiedSince);
  
  RequestPreconditions without({
    final bool ifMatch : false,
    final bool ifModifiedSince : false,
    final bool ifNoneMatch : false,
    final bool ifRange : false,
    final bool ifUnmodifiedSince : false}) =>
        _requestPreconditionsWithout(
            this,
            ifMatch,
            ifModifiedSince,
            ifNoneMatch,
            ifRange,
            ifUnmodifiedSince);
}

abstract class _RequestPreconditionsMixin implements RequestPreconditions {
  String toString() =>
      _requestPreconditionsToString(this);
  
  RequestPreconditions with_({
    final Iterable<EntityTag> ifMatch : const [],
    final DateTime ifModifiedSince,
    final Iterable<EntityTag> ifNoneMatch : const [],
    final Either<EntityTag,DateTime> ifRange,
    final DateTime ifUnmodifiedSince}) =>
        _requestPreconditionsWith(
            this,
            ifMatch,
            ifModifiedSince,
            ifNoneMatch,
            ifRange,
            ifUnmodifiedSince);
  
  RequestPreconditions without({
    final bool ifMatch : false,
    final bool ifModifiedSince : false,
    final bool ifNoneMatch : false,
    final bool ifRange : false,
    final bool ifUnmodifiedSince : false}) =>
        _requestPreconditionsWithout(
            this,
            ifMatch,
            ifModifiedSince,
            ifNoneMatch,
            ifRange,
            ifUnmodifiedSince);
}

class _RequestPreconditionsImpl 
    extends Object
    with _RequestPreconditionsMixin
    implements RequestPreconditions {
  final ImmutableSet<EntityTag> ifMatch;
  final Option<DateTime> ifModifiedSince;
  final ImmutableSet<EntityTag> ifNoneMatch;
  final Option<Either<EntityTag,DateTime>> ifRange;
  final Option<DateTime> ifUnmodifiedSince;
  
  _RequestPreconditionsImpl(this.ifMatch, this.ifModifiedSince, this.ifNoneMatch, this.ifRange, this.ifUnmodifiedSince);
}

final Parser<Either<EntityTag,DateTime>> _IF_RANGE = ETAG ^ HTTP_DATE_TIME;

class _HeadersRequestPreconditionsImpl 
    extends Object 
    with _RequestPreconditionsMixin,
      _Parseable
    implements RequestPreconditions {
  final Multimap<Header, String, dynamic> _headers;
  ImmutableSet<EntityTag> _ifMatch;
  Option<DateTime> _ifModifiedSince;
  ImmutableSet<EntityTag> _ifNoneMatch;
  Option<Either<EntityTag,DateTime>> _ifRange;
  Option<DateTime> _ifUnmodifiedSince;
  
  _HeadersRequestPreconditionsImpl(this._headers);
  
  ImmutableSet<EntityTag> get ifMatch =>
      computeIfNull(_ifMatch, () {
        _ifMatch = 
            _parse(IF_MATCH, Header.IF_MATCH)
              .map((final Iterable<EntityTag> ifMatch) =>
                  Persistent.EMPTY_SET.addAll(ifMatch))
              .orElse(Persistent.EMPTY_SET);
        return _ifMatch;
      });
  
  Option<DateTime> get ifModifiedSince =>
      computeIfNull(_ifModifiedSince, () {
        _ifModifiedSince = 
            _parse(HTTP_DATE_TIME, Header.IF_MODIFIED_SINCE);
        return _ifModifiedSince;
      });
  
  ImmutableSet<EntityTag> get ifNoneMatch =>
      computeIfNull(_ifNoneMatch, () {
        _ifNoneMatch = 
            _parse(IF_NONE_MATCH, Header.IF_NONE_MATCH)
              .map((final Iterable<EntityTag> ifNoneMatch) => 
                  Persistent.EMPTY_SET.addAll(ifNoneMatch))
              .orElse(Persistent.EMPTY_SET);
        return _ifNoneMatch;
      });
  
  Option<Either<EntityTag,DateTime>> get ifRange =>
      computeIfNull(_ifRange, () {
        _ifRange = _parse(_IF_RANGE, Header.IF_RANGE);
        return _ifRange;
      });
  
  Option<DateTime> get ifUnmodifiedSince =>
      computeIfNull(_ifUnmodifiedSince, () {
        _ifUnmodifiedSince = _parse(HTTP_DATE_TIME, Header.IF_UNMODIFIED_SINCE);
        return _ifUnmodifiedSince;
      });
}