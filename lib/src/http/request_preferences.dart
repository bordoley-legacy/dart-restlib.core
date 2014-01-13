part of restlib.core.http;

abstract class RequestPreferences {
  static const RequestPreferences NONE = const _RequestPreferencesNone();
  
  factory RequestPreferences.wrapHeaders(Iterable<String> headers(Header header)) =>
      new _HeadersRequestPreferencesImpl(headers);

  ImmutableSet<Preference<Charset>> get acceptedCharsets;
  
  ImmutableSet<Preference<ContentEncoding>> get acceptedEncodings;
  
  ImmutableSet<Preference<Language>> get acceptedLanguages;
  
  ImmutableSet<Preference<MediaRange>> get acceptedMediaRanges;
 
  Option<Range> get range;
  
  RequestPreferences with_({
    Iterable<Preference<Charset>> acceptedCharsets,
    Iterable<Preference<ContentEncoding>> acceptedEncodings,
    Iterable<Preference<Language>>  acceptedLanguages,
    Iterable<Preference<MediaRange>> acceptedMediaRanges,
    Range range});
}

class _RequestPreferencesNone implements RequestPreferences {
  final Iterable<Preference<Charset>> acceptedCharsets = EMPTY_LIST;
  final Iterable<Preference<ContentEncoding>> acceptedEncodings = EMPTY_LIST;
  final Iterable<Preference<Language>> acceptedLanguages = EMPTY_LIST;
  final Iterable<Preference<MediaRange>> acceptedMediaRanges = EMPTY_LIST;
  final Option<Range> range = Option.NONE;
  
  const _RequestPreferencesNone();
  
  String toString() => "";
  
  RequestPreferences with_({
    final Iterable<Preference<Charset>> acceptedCharsets,
    final Iterable<Preference<ContentEncoding>> acceptedEncodings,
    final Iterable<Preference<Language>>  acceptedLanguages,
    final Iterable<Preference<MediaRange>> acceptedMediaRanges,
    final Range range}) =>
        new _RequestPreferencesImpl._delegating(this, 
            acceptedCharsets: acceptedCharsets, 
            acceptedEncodings: acceptedEncodings, 
            acceptedLanguages: acceptedLanguages, 
            acceptedMediaRanges: acceptedMediaRanges, 
            range: range);
}

abstract class ForwardingRequestPreferences implements Forwarder, RequestPreferences {
  ImmutableSet<Preference<Charset>> get acceptedCharsets =>
      delegate.acceptedCharsets;
  
  ImmutableSet<Preference<ContentEncoding>> get acceptedEncodings =>
      delegate.acceptedEncodings;
  
  ImmutableSet<Preference<Language>> get acceptedLanguages =>
      delegate.acceptedLanguages;
  
  ImmutableSet<Preference<MediaRange>> get acceptedMediaRanges =>
      delegate.acceptedMediaRanges;
 
  Option<Range> get range =>
      delegate.range;
}

class RequestPreferencesBuilder {
  MutableSet<Preference<Charset>> _acceptedCharsets = new MutableSet.hash();
  MutableSet<Preference<ContentEncoding>> _acceptedEncodings = new MutableSet.hash();
  MutableSet<Preference<Language>> _acceptedLanguages = new MutableSet.hash();
  MutableSet<Preference<MediaRange>> _acceptedMediaRanges = new MutableSet.hash();
  Option<Range> _range = Option.NONE;
  
  set Range(final Range range) => 
      _range = new Option(range);
  
  void addAcceptedCharset(final Preference<Charset> charset) {
    _acceptedCharsets.add(charset);
  }
  
  void addAcceptedCharsets(final Iterable<Preference<Charset>> charsets) =>
    _acceptedCharsets.addAll(charsets);
  
  void addAcceptedEncoding(final Preference<ContentEncoding> encoding) {
    _acceptedEncodings.add(encoding);
  }
  
  void addAcceptedEncodings(final Iterable<Preference<ContentEncoding>> encodings) =>
    _acceptedEncodings.addAll(encodings);
  
  void addAcceptedLanguage(final Preference<Language> language) {
    _acceptedLanguages.add(language);
  }
  
  void addAcceptedLanguages(final Iterable<Preference<Language>> languages) =>
    _acceptedLanguages.addAll(languages); 
  
  void addAcceptedMediaRange(final Preference<MediaRange> mediaRange) {
    _acceptedMediaRanges.add(mediaRange);
  }
  
  void addAcceptedMediaRanges(final Iterable<Preference<MediaRange>> mediaRanges) =>
    _acceptedMediaRanges.addAll(mediaRanges);
  
  RequestPreferences build() => new _RequestPreferencesImpl(this);
}

class _RequestPreferencesImpl 
    extends Object 
    with RequestPreferencesToString,
      RequestPreferencesWith_
    implements RequestPreferences{
  final ImmutableSet<Preference<Charset>> acceptedCharsets;
  final ImmutableSet<Preference<ContentEncoding>> acceptedEncodings;
  final ImmutableSet<Preference<Language>> acceptedLanguages;
  final ImmutableSet<Preference<MediaRange>> acceptedMediaRanges;
  final Option<Range> range;
  
  _RequestPreferencesImpl(final RequestPreferencesBuilder builder):
    acceptedCharsets = Persistent.EMPTY_SET.addAll(builder._acceptedCharsets),
    acceptedEncodings = Persistent.EMPTY_SET.addAll(builder._acceptedEncodings), 
    acceptedLanguages = Persistent.EMPTY_SET.addAll(builder._acceptedLanguages),
    acceptedMediaRanges = Persistent.EMPTY_SET.addAll(builder._acceptedMediaRanges),
    range = builder._range;
  
  _RequestPreferencesImpl._delegating(final RequestPreferences delegate, {
    final Iterable<Preference<Charset>> acceptedCharsets,
    final Iterable<Preference<ContentEncoding>> acceptedEncodings,
    final Iterable<Preference<Language>>  acceptedLanguages,
    final Iterable<Preference<MediaRange>> acceptedMediaRanges,
    final Range range}) :
      this.acceptedCharsets = computeIfNotNullOtherwise(acceptedCharsets, delegate.acceptedCharsets, Persistent.EMPTY_SET.addAll),
      this.acceptedEncodings = computeIfNotNullOtherwise(acceptedEncodings, delegate.acceptedEncodings, Persistent.EMPTY_SET.addAll),
      this.acceptedLanguages = computeIfNotNullOtherwise(acceptedLanguages, delegate.acceptedLanguages, Persistent.EMPTY_SET.addAll),
      this.acceptedMediaRanges = computeIfNotNullOtherwise(acceptedMediaRanges, delegate.acceptedMediaRanges, Persistent.EMPTY_SET.addAll),
      this.range = computeIfEmpty(new Option(range), () => delegate.range);
}

abstract class RequestPreferencesToString implements RequestPreferences {
  String toString() =>
      (new StringBuffer()
        ..write(Header.ACCEPT_CHARSET.write(acceptedCharsets))
        ..write(Header.ACCEPT_ENCODING.write(acceptedEncodings))
        ..write(Header.ACCEPT_LANGUAGE.write(acceptedLanguages))
        ..write(Header.ACCEPT.write(acceptedMediaRanges))
        ..write(Header.RANGE.write(range))
      ).toString();
}

abstract class RequestPreferencesWith_ implements RequestPreferences {
  RequestPreferences with_({
    final Iterable<Preference<Charset>> acceptedCharsets,
    final Iterable<Preference<ContentEncoding>> acceptedEncodings,
    final Iterable<Preference<Language>>  acceptedLanguages,
    final Iterable<Preference<MediaRange>> acceptedMediaRanges,
    final Range range}) =>
        new _RequestPreferencesImpl._delegating(this, 
            acceptedCharsets: acceptedCharsets, 
            acceptedEncodings: acceptedEncodings, 
            acceptedLanguages: acceptedLanguages, 
            acceptedMediaRanges: acceptedMediaRanges, 
            range: range);
}

class _HeadersRequestPreferencesImpl 
    extends Object 
    with RequestPreferencesToString,
      RequestPreferencesWith_,
      _Parseable
    implements RequestPreferences {
  final _HeaderFunc headers;
  ImmutableSet<Preference<Charset>> _acceptedCharsets;
  ImmutableSet<Preference<ContentEncoding>> _acceptedEncodings;
  ImmutableSet<Preference<Language>> _acceptedLanguages;
  ImmutableSet<Preference<MediaRange>> _acceptedMediaRanges;
  Option<Range> _range;
  
  _HeadersRequestPreferencesImpl(this.headers);
  
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