part of restlib.core.http;

String _requestPreferencesToString(final RequestPreferences requestPreferences) =>
    (new StringBuffer()
      ..write(Header.ACCEPT_CHARSET.write(requestPreferences.acceptedCharsets))
      ..write(Header.ACCEPT_ENCODING.write(requestPreferences.acceptedEncodings))
      ..write(Header.ACCEPT_LANGUAGE.write(requestPreferences.acceptedLanguages))
      ..write(Header.ACCEPT.write(requestPreferences.acceptedMediaRanges))
      ..write(Header.RANGE.write(requestPreferences.range))
    ).toString();
    
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
      Persistent.EMPTY_SET.addAll(firstNotNull(acceptedCharsets, delegate.acceptedCharsets)), 
      Persistent.EMPTY_SET.addAll(firstNotNull(acceptedEncodings, delegate.acceptedEncodings)), 
      Persistent.EMPTY_SET.addAll(firstNotNull(acceptedLanguages, delegate.acceptedLanguages)), 
      Persistent.EMPTY_SET.addAll(firstNotNull(acceptedMediaRanges, delegate.acceptedMediaRanges)), 
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
      !acceptedCharsets ? Persistent.EMPTY_SET.addAll(delegate.acceptedCharsets) : Persistent.EMPTY_SET,
      !acceptedEncodings ? Persistent.EMPTY_SET.addAll(delegate.acceptedEncodings) : Persistent.EMPTY_SET,
      !acceptedLanguages ? Persistent.EMPTY_SET.addAll(delegate.acceptedLanguages) : Persistent.EMPTY_SET,
      !acceptedMediaRanges ? Persistent.EMPTY_SET.addAll(delegate.acceptedMediaRanges) : Persistent.EMPTY_SET,
      !range ? delegate.range : Option.NONE);
}

abstract class RequestPreferences {
  static const RequestPreferences NONE = const _RequestPreferencesNone();
  
  factory RequestPreferences({
    final Iterable<Preference<Charset>> acceptedCharsets : const [],
    final Iterable<Preference<ContentEncoding>> acceptedEncodings : const [],
    final Iterable<Preference<Language>>  acceptedLanguages : const [],
    final Iterable<Preference<MediaRange>> acceptedMediaRanges : const [],
    final Range range}) {
    
    if(isNull(acceptedCharsets) && 
        isNull(acceptedEncodings) &&
        isNull(acceptedLanguages) &&
        isNull(acceptedMediaRanges) &&
        isNull(range)) {
      return RequestPreferences.NONE;
    }
    
    return new _RequestPreferencesImpl(
        Persistent.EMPTY_SET.addAll(acceptedCharsets),
        Persistent.EMPTY_SET.addAll(acceptedEncodings),
        Persistent.EMPTY_SET.addAll(acceptedLanguages),
        Persistent.EMPTY_SET.addAll(acceptedMediaRanges),
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
  final ImmutableSet<Preference<Charset>> acceptedCharsets = Persistent.EMPTY_SET;
  final ImmutableSet<Preference<ContentEncoding>> acceptedEncodings = Persistent.EMPTY_SET;
  final ImmutableSet<Preference<Language>> acceptedLanguages = Persistent.EMPTY_SET;
  final ImmutableSet<Preference<MediaRange>> acceptedMediaRanges = Persistent.EMPTY_SET;
  final Option<Range> range = Option.NONE;
  
  const _RequestPreferencesNone();
  
  String toString() => "";
  
  RequestPreferences with_({
    final Iterable<Preference<Charset>> acceptedCharsets,
    final Iterable<Preference<ContentEncoding>> acceptedEncodings,
    final Iterable<Preference<Language>>  acceptedLanguages,
    final Iterable<Preference<MediaRange>> acceptedMediaRanges,
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

abstract class ForwardingRequestPreferences implements Forwarder, RequestPreferences {
  FiniteSet<Preference<Charset>> get acceptedCharsets =>
      delegate.acceptedCharsets;
  
  FiniteSet<Preference<ContentEncoding>> get acceptedEncodings =>
      delegate.acceptedEncodings;
  
  FiniteSet<Preference<Language>> get acceptedLanguages =>
      delegate.acceptedLanguages;
  
  FiniteSet<Preference<MediaRange>> get acceptedMediaRanges =>
      delegate.acceptedMediaRanges;
 
  Option<Range> get range =>
      delegate.range;
  
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
        _acceptedCharsets = 
            _parse(ACCEPT_CHARSET, Header.ACCEPT_CHARSET)
              .map((final Iterable<Preference<Charset>> acceptedCharsets) => 
                  Persistent.EMPTY_SET.addAll(acceptedCharsets))
              .orElse(Persistent.EMPTY_SET);
        return _acceptedCharsets;
      });
  
  ImmutableSet<Preference<ContentEncoding>> get acceptedEncodings =>
      computeIfNull(_acceptedEncodings, () {
        _acceptedEncodings = 
            _parse(ACCEPT_ENCODING, Header.ACCEPT_ENCODING)
              .map((final Iterable<Preference<ContentEncoding>> acceptedEncodings) =>
                  Persistent.EMPTY_SET.addAll(acceptedEncodings))
              .orElse(Persistent.EMPTY_SET);
        return _acceptedEncodings;
      });
  
  ImmutableSet<Preference<Language>> get acceptedLanguages =>
      computeIfNull(_acceptedLanguages, () {
        _acceptedLanguages = 
            _parse(ACCEPT_LANGUAGE, Header.ACCEPT_LANGUAGE)
              .map((final Iterable<Preference<Language>> acceptedLanguages) =>
                  Persistent.EMPTY_SET.addAll(acceptedLanguages))
              .orElse(Persistent.EMPTY_SET);    
            
        return _acceptedLanguages;
      });
  
  ImmutableSet<Preference<MediaRange>> get acceptedMediaRanges =>
      computeIfNull(_acceptedMediaRanges, () {
        _acceptedMediaRanges = 
            _parse(ACCEPT, Header.ACCEPT)
              .map((final Iterable<Preference<MediaRange>> acceptedMediaRanges) =>
                  Persistent.EMPTY_SET.addAll(acceptedMediaRanges))
              .orElse(Persistent.EMPTY_SET);
        
        return _acceptedMediaRanges;
      });
  
  Option<Range> get range =>
      computeIfNull(_range, () {
        _range = _parse(RANGE, Header.RANGE);
        return _range;
      });
}