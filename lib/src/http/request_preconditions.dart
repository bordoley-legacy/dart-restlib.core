part of restlib.core.http;

abstract class RequestPreconditions {
  static const RequestPreconditions NONE = const _RequestPreconditionsNone();
  
  factory RequestPreconditions.wrapHeaders(final Associative<String, String> headers) =>
      new _HeadersRequestPreconditionsImpl(headers);
  
  ImmutableSet<EntityTag> get ifMatch;
  Option<DateTime> get ifModifiedSince;
  
  ImmutableSet<EntityTag> get ifNoneMatch;
  Option<Either<EntityTag,DateTime>> get ifRange;
  Option<DateTime> get ifUnmodifiedSince;
  
  RequestPreconditions with_({
    Iterable<EntityTag> ifMatch,
    DateTime ifModifiedSince,
    Iterable<EntityTag> ifNoneMatch,
    Either<EntityTag,DateTime> ifRange,
    DateTime ifUnmodifiedSince});                             
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
    final Iterable<EntityTag> ifMatch,
    final DateTime ifModifiedSince,
    final Iterable<EntityTag> ifNoneMatch,
    final Either<EntityTag,DateTime> ifRange,
    final DateTime ifUnmodifiedSince}) =>
        new _RequestPreconditionsImpl._delegating(this, 
            ifMatch: ifMatch, 
            ifModifiedSince: ifModifiedSince, 
            ifNoneMatch: ifNoneMatch, 
            ifRange: ifRange, 
            ifUnmodifiedSince: ifUnmodifiedSince);
}

abstract class ForwardingRequestPreconditions implements Forwarder, RequestPreconditions {
  ImmutableSet<EntityTag> get ifMatch =>
      delegate.ifMatch;
  
  Option<DateTime> get ifModifiedSince =>
      delegate.ifModifiedSince;
  
  ImmutableSet<EntityTag> get ifNoneMatch =>
      delegate.ifNoneMatch;
  
  Option<Either<EntityTag,DateTime>> get ifRange =>
      delegate.ifRange;
  
  Option<DateTime> get ifUnmodifiedSince =>
      delegate.ifUnmodifiedSince;
}

class RequestPreconditionsBuilder {
  MutableSet<EntityTag> _ifMatch = new MutableSet.hash();
  Option<DateTime> _ifModifiedSince = Option.NONE;
  MutableSet<EntityTag> _ifNoneMatch = new MutableSet.hash();
  Option<Either<EntityTag,DateTime>> _ifRange = Option.NONE;
  Option<DateTime> _ifUnmodifiedSince = Option.NONE;
  
  set ifRangeDate(final DateTime date) =>
    _ifRange = new Option(new Either.rightValue(date));
  
  set ifRangeTag(final EntityTag tag) =>
    _ifRange = new Option(new Either.leftValue(tag));
  
  set ifUnmodifiedSince (final DateTime date) =>
    _ifUnmodifiedSince = new Option(date);
  
  void addIfMatchTag(final EntityTag tag) { 
    _ifMatch.add(tag);
  }
  
  set ifModifiedSince (final DateTime date) => 
      _ifModifiedSince = new Option(date);
  
  void addIfNoneMatchTag(final EntityTag tag) { 
    _ifNoneMatch.add(tag);
  }
  
  RequestPreconditions build() => 
      new _RequestPreconditionsImpl(this);
}

class _RequestPreconditionsImpl 
    extends Object 
    with RequestPreconditionsToString,
      RequestPreconditionsWith_
    implements RequestPreconditions {
  final ImmutableSet<EntityTag> ifMatch;
  final Option<DateTime> ifModifiedSince;
  final ImmutableSet<EntityTag> ifNoneMatch;
  final Option<Either<EntityTag,DateTime>> ifRange;
  final Option<DateTime> ifUnmodifiedSince;
  
  _RequestPreconditionsImpl(final RequestPreconditionsBuilder builder) :
    ifMatch = Persistent.EMPTY_SET.addAll(builder._ifMatch), 
    ifModifiedSince = builder._ifModifiedSince,
    ifNoneMatch = Persistent.EMPTY_SET.addAll(builder._ifNoneMatch),
    ifRange = builder._ifRange,
    ifUnmodifiedSince = builder._ifUnmodifiedSince;
  
  _RequestPreconditionsImpl._delegating(final RequestPreconditions delegate, {
    final Iterable<EntityTag> ifMatch,
    final DateTime ifModifiedSince,
    final Iterable<EntityTag> ifNoneMatch,
    final Either<EntityTag,DateTime> ifRange,
    final DateTime ifUnmodifiedSince}) :
      this.ifMatch = computeIfNotNullOtherwise(ifMatch, delegate.ifMatch, Persistent.EMPTY_SET.addAll),
      this.ifModifiedSince = computeIfEmpty(new Option(ifModifiedSince), () => delegate.ifModifiedSince),
      this.ifNoneMatch = computeIfNotNullOtherwise(ifNoneMatch, delegate.ifNoneMatch, Persistent.EMPTY_SET.addAll),
      this.ifRange = computeIfEmpty(new Option(ifRange), () => delegate.ifRange),
      this.ifUnmodifiedSince = computeIfEmpty(new Option(ifUnmodifiedSince), () => delegate.ifUnmodifiedSince);
}

abstract class RequestPreconditionsToString implements RequestPreconditions {
  String toString() => 
      (new StringBuffer()
        ..write(Header.IF_MATCH.write(ifMatch))
        ..write(Header.IF_MODIFIED_SINCE.write(ifModifiedSince))
        ..write(Header.IF_NONE_MATCH.write(ifNoneMatch))
        ..write(Header.IF_RANGE.write(
            ifRange.map(
                (final Either<EntityTag, DateTime> ifRange) =>
                    ifRange.value)))
      ..write(Header.IF_UNMODIFIED_SINCE.write(ifUnmodifiedSince))
    ).toString();
}

abstract class RequestPreconditionsWith_ implements RequestPreconditions {
  RequestPreconditions with_({
    final Iterable<EntityTag> ifMatch,
    final DateTime ifModifiedSince,
    final Iterable<EntityTag> ifNoneMatch,
    final Either<EntityTag,DateTime> ifRange,
    final DateTime ifUnmodifiedSince}) =>
        new _RequestPreconditionsImpl._delegating(this, 
            ifMatch: ifMatch, 
            ifModifiedSince: ifModifiedSince, 
            ifNoneMatch: ifNoneMatch, 
            ifRange: ifRange, 
            ifUnmodifiedSince: ifUnmodifiedSince);
}

final Parser<Either<EntityTag,DateTime>> _ETAG_OR_DATETIME = ETAG ^ HTTP_DATE_TIME;

class _HeadersRequestPreconditionsImpl 
    extends Object 
    with RequestPreconditionsToString,
      RequestPreconditionsWith_,
      _Parseable
    implements RequestPreconditions {
  final Associative<String, String> headers;
  ImmutableSet<EntityTag> _ifMatch;
  Option<DateTime> _ifModifiedSince;
  ImmutableSet<EntityTag> _ifNoneMatch;
  Option<Either<EntityTag,DateTime>> _ifRange;
  Option<DateTime> _ifUnmodifiedSince;
  
  _HeadersRequestPreconditionsImpl(this.headers);
  
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
        _ifRange = _parse(_ETAG_OR_DATETIME, Header.IF_RANGE);
        return _ifRange;
      });
  
  Option<DateTime> get ifUnmodifiedSince =>
      computeIfNull(_ifUnmodifiedSince, () {
        _ifUnmodifiedSince = _parse(HTTP_DATE_TIME, Header.IF_UNMODIFIED_SINCE);
        return _ifUnmodifiedSince;
      });
}