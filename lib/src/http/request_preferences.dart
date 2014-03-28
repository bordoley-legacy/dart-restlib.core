part of http;

void _writeRequestPreferences(final RequestPreferences preferences, void writeHeaderLine(final String header, final String value)) {
  _writeHeader(ACCEPT_CHARSET, preferences.acceptedCharsets, writeHeaderLine);
  _writeHeader(ACCEPT_ENCODING, preferences.acceptedEncodings, writeHeaderLine);
  _writeHeader(ACCEPT_LANGUAGE, preferences.acceptedLanguages, writeHeaderLine);
  _writeHeader(ACCEPT, preferences.acceptedMediaRanges, writeHeaderLine);
  _writeHeader(RANGE, preferences.range, writeHeaderLine);
}

abstract class RequestPreferences {
  static const RequestPreferences NONE = const _RequestPreferencesNone();

  factory RequestPreferences({
    final Iterable<Preference<Charset>> acceptedCharsets,
    final Iterable<Preference<ContentEncoding>> acceptedEncodings,
    final Iterable<Preference<Language>>  acceptedLanguages,
    final Iterable<Preference<MediaRange>> acceptedMediaRanges,
    final data.Range range}) {

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
      new _RequestPreferencesImpl(
          null, null, null, null, null, checkNotNull(headers));

  FiniteSet<Preference<Charset>> get acceptedCharsets;

  FiniteSet<Preference<ContentEncoding>> get acceptedEncodings;

  FiniteSet<Preference<Language>> get acceptedLanguages;

  FiniteSet<Preference<MediaRange>> get acceptedMediaRanges;

  Option<data.Range> get range;

  String toString();

  RequestPreferences with_({
    Iterable<Preference<Charset>> acceptedCharsets,
    Iterable<Preference<ContentEncoding>> acceptedEncodings,
    Iterable<Preference<Language>>  acceptedLanguages,
    Iterable<Preference<MediaRange>> acceptedMediaRanges,
    data.Range range});

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
  final Option<data.Range> range = Option.NONE;

  const _RequestPreferencesNone();

  String toString() => "";

  RequestPreferences with_({
    final Iterable<Preference<Charset>> acceptedCharsets,
    final Iterable<Preference<ContentEncoding>> acceptedEncodings,
    final Iterable<Preference<Language>>  acceptedLanguages,
    final Iterable<Preference<MediaRange>> acceptedMediaRanges,
    final data.Range range}) =>
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

class _RequestPreferencesImpl
    extends Object
    with  _Parseable
    implements RequestPreferences {
  final Multimap<Header, String, dynamic> _headers;
  ImmutableSet<Preference<Charset>> _acceptedCharsets;
  ImmutableSet<Preference<ContentEncoding>> _acceptedEncodings;
  ImmutableSet<Preference<Language>> _acceptedLanguages;
  ImmutableSet<Preference<MediaRange>> _acceptedMediaRanges;
  Option<data.Range> _range;

  _RequestPreferencesImpl(
      this._acceptedCharsets, this._acceptedEncodings, this._acceptedLanguages,
        this._acceptedMediaRanges, this._range, [this._headers = EMPTY_SEQUENCE_MULTIMAP]);

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

  Option<data.Range> get range =>
      computeIfNull(_range, () {
        _range = _parse(data.Range.parser, RANGE);
        return _range;
      });

  String toString() {
    final StringBuffer buffer = new StringBuffer();
    _writeRequestPreferences(this, _writeHeaderToBuffer(buffer));
    return buffer.toString();
  }

  RequestPreferences with_({
      final Iterable<Preference<Charset>> acceptedCharsets,
      final Iterable<Preference<ContentEncoding>> acceptedEncodings,
      final Iterable<Preference<Language>>  acceptedLanguages,
      final Iterable<Preference<MediaRange>> acceptedMediaRanges,
      final data.Range range}) {

    if (isNull(acceptedCharsets) &&
        isNull(acceptedEncodings) &&
        isNull(acceptedLanguages) &&
        isNull(acceptedMediaRanges) &&
        isNull(range)) {
      return this;
    }

    return new _RequestPreferencesImpl(
        isNotNull(acceptedCharsets) ? EMPTY_SET.addAll(acceptedCharsets) : _acceptedCharsets,
        isNotNull(acceptedEncodings) ? EMPTY_SET.addAll(acceptedEncodings) : _acceptedEncodings,
        isNotNull(acceptedLanguages) ? EMPTY_SET.addAll(acceptedLanguages) : _acceptedLanguages,
        isNotNull(acceptedMediaRanges) ? EMPTY_SET.addAll(acceptedMediaRanges) : _acceptedMediaRanges,
        computeIfEmpty(new Option(range), () => _range),
        _headers);
  }

  RequestPreferences without({
    final bool acceptedCharsets : false,
    final bool acceptedEncodings : false,
    final bool acceptedLanguages : false,
    final bool acceptedMediaRanges : false,
    final bool range : false}) {

    if (acceptedCharsets && acceptedEncodings && acceptedLanguages && acceptedMediaRanges && range) {
      return RequestPreferences.NONE;
    }

    return new _RequestPreferencesImpl(
        acceptedCharsets ? EMPTY_SET : _acceptedCharsets,
        acceptedEncodings ? EMPTY_SET : _acceptedEncodings,
        acceptedLanguages ? EMPTY_SET : _acceptedLanguages,
        acceptedMediaRanges ? EMPTY_SET : _acceptedMediaRanges,
        range ? Option.NONE : _range,
        _headers);
  }
}