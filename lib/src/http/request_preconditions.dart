part of http;

void _writeRequestPreconditions(final RequestPreconditions preconditions, void writeHeaderLine(final String header, final String value)) {
  _writeHeader(IF_MATCH, preconditions.ifMatch, writeHeaderLine);
  _writeHeader(IF_MODIFIED_SINCE, preconditions.ifModifiedSince, writeHeaderLine);
  _writeHeader(IF_NONE_MATCH, preconditions.ifNoneMatch, writeHeaderLine);
  _writeHeader(IF_RANGE, preconditions.ifRange.map((final Either<EntityTag, DateTime> ifRange) => ifRange.value), writeHeaderLine);
  _writeHeader(IF_UNMODIFIED_SINCE, preconditions.ifUnmodifiedSince, writeHeaderLine);
}

abstract class RequestPreconditions {
  static const RequestPreconditions NONE = const _RequestPreconditionsNone();

  factory RequestPreconditions({
    final Iterable<EntityTag> ifMatch,
    final DateTime ifModifiedSince,
    final Iterable<EntityTag> ifNoneMatch,
    final Either<EntityTag,DateTime> ifRange,
    final DateTime ifUnmodifiedSince}) {

    if (isNull(ifMatch) &&
        isNull(ifModifiedSince) &&
        isNull(ifNoneMatch) &&
        isNull(ifRange) &&
        isNull(ifUnmodifiedSince)) {
      return RequestPreconditions.NONE;
    }

    return new _RequestPreconditionsImpl(
        EMPTY_SET.addAll(firstNotNull(ifMatch, EMPTY_LIST)),
        new Option(ifModifiedSince),
        EMPTY_SET.addAll(firstNotNull(ifNoneMatch,  EMPTY_LIST)),
        new Option(ifRange),
        new Option(ifUnmodifiedSince));
  }

  factory RequestPreconditions.wrapHeaders(final Multimap<Header, String, dynamic> headers) =>
      new _RequestPreconditionsImpl(
          null, null, null, null, null, headers);

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
  final ImmutableSet<EntityTag> ifMatch = EMPTY_SET;
  final Option<DateTime> ifModifiedSince = Option.NONE;
  final ImmutableSet<EntityTag> ifNoneMatch = EMPTY_SET;
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

final Parser<Either<EntityTag,DateTime>> _IF_RANGE = EntityTag.parser ^ HTTP_DATE_TIME;

class _RequestPreconditionsImpl
    extends Object
    with _Parseable
    implements RequestPreconditions {
  final Multimap<Header, String, dynamic> _headers;
  ImmutableSet<EntityTag> _ifMatch;
  Option<DateTime> _ifModifiedSince;
  ImmutableSet<EntityTag> _ifNoneMatch;
  Option<Either<EntityTag,DateTime>> _ifRange;
  Option<DateTime> _ifUnmodifiedSince;

  _RequestPreconditionsImpl(
      this._ifMatch, this._ifModifiedSince, this._ifNoneMatch,
        this._ifRange, this._ifUnmodifiedSince, [this._headers = EMPTY_SEQUENCE_MULTIMAP]);

  ImmutableSet<EntityTag> get ifMatch =>
      computeIfNull(_ifMatch, () {
        _ifMatch = _parse(_IF_MATCH, IF_MATCH).map(EMPTY_SET.addAll).orElse(EMPTY_SET);
        return _ifMatch;
      });

  Option<DateTime> get ifModifiedSince =>
      computeIfNull(_ifModifiedSince, () {
        _ifModifiedSince = _parse(HTTP_DATE_TIME, IF_MODIFIED_SINCE);
        return _ifModifiedSince;
      });

  ImmutableSet<EntityTag> get ifNoneMatch =>
      computeIfNull(_ifNoneMatch, () {
        _ifNoneMatch = _parse(_IF_NONE_MATCH, IF_NONE_MATCH).map(EMPTY_SET.addAll).orElse(EMPTY_SET);
        return _ifNoneMatch;
      });

  Option<Either<EntityTag,DateTime>> get ifRange =>
      computeIfNull(_ifRange, () {
        _ifRange = _parse(_IF_RANGE, IF_RANGE);
        return _ifRange;
      });

  Option<DateTime> get ifUnmodifiedSince =>
      computeIfNull(_ifUnmodifiedSince, () {
        _ifUnmodifiedSince = _parse(HTTP_DATE_TIME, IF_UNMODIFIED_SINCE);
        return _ifUnmodifiedSince;
      });

  String toString() {
    final StringBuffer buffer = new StringBuffer();
    _writeRequestPreconditions(this, _writeHeaderToBuffer(buffer));
    return buffer.toString();
  }

  RequestPreconditions with_({
      final RequestPreconditions delegate,
      final Iterable<EntityTag> ifMatch,
      final DateTime ifModifiedSince,
      final Iterable<EntityTag> ifNoneMatch,
      final Either<EntityTag,DateTime> ifRange,
      final DateTime ifUnmodifiedSince}) {

    if (isNull(ifMatch) &&
        isNull(ifModifiedSince) &&
        isNull(ifNoneMatch) &&
        isNull(ifRange) &&
        isNull(ifUnmodifiedSince)) {
      return this;
    }

    return new _RequestPreconditionsImpl(
        isNotNull(ifMatch) ? EMPTY_SET.addAll(ifMatch) : _ifMatch,
        isNotNull(ifModifiedSince) ? new Option(ifModifiedSince) : _ifModifiedSince,
        isNotNull(ifNoneMatch) ? EMPTY_SET.addAll(ifNoneMatch) : _ifNoneMatch,
        isNotNull(ifRange) ? new Option(ifRange) : _ifRange,
        isNotNull(ifUnmodifiedSince) ? new Option(ifUnmodifiedSince) : _ifUnmodifiedSince,
        _headers);
  }

  RequestPreconditions without({
    final RequestPreconditions delegate,
    final bool ifMatch,
    final bool ifModifiedSince,
    final bool ifNoneMatch,
    final bool ifRange,
    final bool ifUnmodifiedSince}) {

    if (ifMatch && ifModifiedSince && ifNoneMatch && ifRange && ifUnmodifiedSince) {
      return RequestPreconditions.NONE;
    }

    return new _RequestPreconditionsImpl(
        ifMatch ?  EMPTY_SET : _ifMatch,
        ifModifiedSince ? Option.NONE : _ifModifiedSince,
        ifNoneMatch ? EMPTY_SET : _ifNoneMatch,
        ifRange ? Option.NONE : _ifRange,
        ifUnmodifiedSince ? Option.NONE : _ifUnmodifiedSince,
        _headers);
  }
}