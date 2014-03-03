part of restlib.core.http;

void _writeRequestPreferences(final RequestPreferences preferences, void writeHeaderLine(final String header, final String value)) {
  _writeHeader(ACCEPT_CHARSET, preferences.acceptedCharsets, writeHeaderLine);
  _writeHeader(ACCEPT_ENCODING, preferences.acceptedEncodings, writeHeaderLine);
  _writeHeader(ACCEPT_LANGUAGE, preferences.acceptedLanguages, writeHeaderLine);
  _writeHeader(ACCEPT, preferences.acceptedMediaRanges, writeHeaderLine);
  _writeHeader(RANGE, preferences.range, writeHeaderLine);
}

String _requestPreferencesToString(final RequestPreferences preferences) {
  final StringBuffer buffer = new StringBuffer();
  _WriteHeaderLine writeHeaderLine = _writeHeaderToBuffer(buffer);

  _writeRequestPreferences(preferences, writeHeaderLine);

  return buffer.toString();
}

RequestPreferences _requestPreferencesWith(
  final RequestPreferences delegate,
  final Iterable<Preference<Charset>> acceptedCharsets,
  final Iterable<Preference<ContentEncoding>> acceptedEncodings,
  final Iterable<Preference<Language>>  acceptedLanguages,
  final Iterable<Preference<MediaRange>> acceptedMediaRanges,
  final Range range) {

  if (isNull(acceptedCharsets) && isNull(acceptedEncodings) && isNull(acceptedLanguages) && isNull(acceptedMediaRanges) && isNull(range)) {
    return delegate;
  }

  return new _RequestPreferencesImpl(
      EMPTY_SET.addAll(firstNotNull(acceptedCharsets, delegate.acceptedCharsets)),
      EMPTY_SET.addAll(firstNotNull(acceptedEncodings, delegate.acceptedEncodings)),
      EMPTY_SET.addAll(firstNotNull(acceptedLanguages, delegate.acceptedLanguages)),
      EMPTY_SET.addAll(firstNotNull(acceptedMediaRanges, delegate.acceptedMediaRanges)),
      computeIfEmpty(new Option(range), () => delegate.range));
}

RequestPreferences _requestPreferencesWithout(
  final RequestPreferences delegate,
  final bool acceptedCharsets,
  final bool acceptedEncodings,
  final bool acceptedLanguages,
  final bool acceptedMediaRanges,
  final bool range) {

  if (acceptedCharsets && acceptedEncodings && acceptedLanguages && acceptedMediaRanges && range) {
    return RequestPreferences.NONE;
  }

  return new _RequestPreferencesImpl(
      !acceptedCharsets ? EMPTY_SET.addAll(delegate.acceptedCharsets) : EMPTY_SET,
      !acceptedEncodings ? EMPTY_SET.addAll(delegate.acceptedEncodings) : EMPTY_SET,
      !acceptedLanguages ? EMPTY_SET.addAll(delegate.acceptedLanguages) : EMPTY_SET,
      !acceptedMediaRanges ? EMPTY_SET.addAll(delegate.acceptedMediaRanges) : EMPTY_SET,
      !range ? delegate.range : Option.NONE);
}

abstract class RequestPreferences {
  static const RequestPreferences NONE = const _RequestPreferencesNone();

  factory RequestPreferences({
    final Iterable<Preference<Charset>> acceptedCharsets,
    final Iterable<Preference<ContentEncoding>> acceptedEncodings,
    final Iterable<Preference<Language>>  acceptedLanguages,
    final Iterable<Preference<MediaRange>> acceptedMediaRanges,
    final Range range}) {

    if(isNull(acceptedCharsets) &&
        isNull(acceptedEncodings) &&
        isNull(acceptedLanguages) &&
        isNull(acceptedMediaRanges) &&
        isNull(range)) {
      return RequestPreferences.NONE;
    }

    return new _RequestPreferencesImpl(
        EMPTY_SET.addAll(firstNotNull(acceptedCharsets, EMPTY_LIST)),
        EMPTY_SET.addAll(firstNotNull(acceptedEncodings, EMPTY_LIST)),
        EMPTY_SET.addAll(firstNotNull(acceptedLanguages, EMPTY_LIST)),
        EMPTY_SET.addAll(firstNotNull(acceptedMediaRanges, EMPTY_LIST)),
        new Option(range));
  }

  factory RequestPreferences.wrapHeaders(final Multimap<Header, String, dynamic> headers) =>
      new _HeadersRequestPreferencesImpl(headers);

  FiniteSet<Preference<Charset>> get acceptedCharsets;

  FiniteSet<Preference<ContentEncoding>> get acceptedEncodings;

  FiniteSet<Preference<Language>> get acceptedLanguages;

  FiniteSet<Preference<MediaRange>> get acceptedMediaRanges;

  Option<Range> get range;

  String toString();

  RequestPreferences with_({
    Iterable<Preference<Charset>> acceptedCharsets,
    Iterable<Preference<ContentEncoding>> acceptedEncodings,
    Iterable<Preference<Language>>  acceptedLanguages,
    Iterable<Preference<MediaRange>> acceptedMediaRanges,
    Range range});

  RequestPreferences without({
    bool acceptedCharsets : false,
    bool acceptedEncodings : false,
    bool acceptedLanguages : false,
    bool acceptedMediaRanges : false,
    bool range : false});
}

class _RequestPreferencesNone implements RequestPreferences {
  final ImmutableSet<Preference<Charset>> acceptedCharsets = EMPTY_SET;
  final ImmutableSet<Preference<ContentEncoding>> acceptedEncodings = EMPTY_SET;
  final ImmutableSet<Preference<Language>> acceptedLanguages = EMPTY_SET;
  final ImmutableSet<Preference<MediaRange>> acceptedMediaRanges = EMPTY_SET;
  final Option<Range> range = Option.NONE;

  const _RequestPreferencesNone();

  String toString() => "";

  RequestPreferences with_({
    final Iterable<Preference<Charset>> acceptedCharsets : const [],
    final Iterable<Preference<ContentEncoding>> acceptedEncodings : const [],
    final Iterable<Preference<Language>>  acceptedLanguages : const [],
    final Iterable<Preference<MediaRange>> acceptedMediaRanges : const [],
    final Range range}) =>
        new RequestPreferences(
            acceptedCharsets: acceptedCharsets,
            acceptedEncodings: acceptedEncodings,
            acceptedLanguages: acceptedLanguages,
            acceptedMediaRanges: acceptedMediaRanges,
            range: range);

  RequestPreferences without({
    final bool acceptedCharsets : false,
    final bool acceptedEncodings : false,
    final bool acceptedLanguages : false,
    final bool acceptedMediaRanges : false,
    final bool range : false}) =>
        this;
}

abstract class _RequestPreferencesMixin implements RequestPreferences{
  String toString() =>
      _requestPreferencesToString(this);

  RequestPreferences with_({
    final Iterable<Preference<Charset>> acceptedCharsets,
    final Iterable<Preference<ContentEncoding>> acceptedEncodings,
    final Iterable<Preference<Language>>  acceptedLanguages,
    final Iterable<Preference<MediaRange>> acceptedMediaRanges,
    final Range range}) =>
        _requestPreferencesWith(
            this,
            acceptedCharsets,
            acceptedEncodings,
            acceptedLanguages,
            acceptedMediaRanges,
            range);

  RequestPreferences without({
    final bool acceptedCharsets : false,
    final bool acceptedEncodings : false,
    final bool acceptedLanguages : false,
    final bool acceptedMediaRanges : false,
    final bool range : false}) =>
        _requestPreferencesWithout(
            this,
            acceptedCharsets,
            acceptedEncodings,
            acceptedLanguages,
            acceptedMediaRanges,
            range);
}

class _RequestPreferencesImpl
    extends Object
    with _RequestPreferencesMixin
    implements RequestPreferences{
  final ImmutableSet<Preference<Charset>> acceptedCharsets;
  final ImmutableSet<Preference<ContentEncoding>> acceptedEncodings;
  final ImmutableSet<Preference<Language>> acceptedLanguages;
  final ImmutableSet<Preference<MediaRange>> acceptedMediaRanges;
  final Option<Range> range;

  _RequestPreferencesImpl(this.acceptedCharsets, this.acceptedEncodings, this.acceptedLanguages, this.acceptedMediaRanges, this.range);
}

class _HeadersRequestPreferencesImpl
    extends Object
    with _RequestPreferencesMixin,
      _Parseable
    implements RequestPreferences {
  final Multimap<Header, String, dynamic> _headers;
  ImmutableSet<Preference<Charset>> _acceptedCharsets;
  ImmutableSet<Preference<ContentEncoding>> _acceptedEncodings;
  ImmutableSet<Preference<Language>> _acceptedLanguages;
  ImmutableSet<Preference<MediaRange>> _acceptedMediaRanges;
  Option<Range> _range;

  _HeadersRequestPreferencesImpl(this._headers);

  ImmutableSet<Preference<Charset>> get acceptedCharsets =>
      computeIfNull(_acceptedCharsets, () {
        _acceptedCharsets = _parse(_ACCEPT_CHARSET, ACCEPT_CHARSET).map(EMPTY_SET.addAll).orElse(EMPTY_SET);
        return _acceptedCharsets;
      });

  ImmutableSet<Preference<ContentEncoding>> get acceptedEncodings =>
      computeIfNull(_acceptedEncodings, () {
        _acceptedEncodings = _parse(_ACCEPT_ENCODING, ACCEPT_ENCODING).map(EMPTY_SET.addAll).orElse(EMPTY_SET);
        return _acceptedEncodings;
      });

  ImmutableSet<Preference<Language>> get acceptedLanguages =>
      computeIfNull(_acceptedLanguages, () {
        _acceptedLanguages = _parse(_ACCEPT_LANGUAGE, ACCEPT_LANGUAGE).map(EMPTY_SET.addAll).orElse(EMPTY_SET);
        return _acceptedLanguages;
      });

  ImmutableSet<Preference<MediaRange>> get acceptedMediaRanges =>
      computeIfNull(_acceptedMediaRanges, () {
        _acceptedMediaRanges = _parse(_ACCEPT, ACCEPT).map(EMPTY_SET.addAll).orElse(EMPTY_SET);
        return _acceptedMediaRanges;
      });

  Option<Range> get range =>
      computeIfNull(_range, () {
        _range = _parse(Range.parser, RANGE);
        return _range;
      });
}