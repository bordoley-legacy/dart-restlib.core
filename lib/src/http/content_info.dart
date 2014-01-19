part of restlib.core.http;

String _contentInfoToString(final ContentInfo contentInfo) => 
    (new StringBuffer()
      ..write(Header.CONTENT_ENCODING.write(contentInfo.encodings))
      ..write(Header.CONTENT_LANGUAGE.write(contentInfo.languages))
      ..write(Header.CONTENT_LENGTH.write(contentInfo.length))
      ..write(Header.CONTENT_LOCATION.write(contentInfo.location))
      ..write(Header.CONTENT_TYPE.write(contentInfo.mediaRange))
      ..write(Header.CONTENT_RANGE.write(contentInfo.range))
    ).toString();

ContentInfo _contentInfoWith(
  final ContentInfo delegate,
  final Iterable<ContentEncoding> encodings,
  final Iterable<Language> languages,
  final int length,
  final Uri location,
  final MediaRange mediaRange,
  final ContentRange range) {
  
  if(isNull(encodings) && 
      isNull(languages) && 
      isNull(length) && 
      isNull(length) && 
      isNull(location) && 
      isNull(mediaRange) && 
      isNull(range)) {
    return delegate;
  }
  
  return new _ContentInfoImpl(
      Persistent.EMPTY_SEQUENCE.addAll(firstNotNull(encodings, delegate.encodings)), 
      Persistent.EMPTY_SET.addAll(firstNotNull(languages, delegate.languages)), 
      computeIfEmpty(new Option(length), () => delegate.length), 
      computeIfEmpty(new Option(location), () => delegate.location), 
      computeIfEmpty(new Option(mediaRange), () => delegate.mediaRange), 
      computeIfEmpty(new Option(range), () => delegate.range));
}

ContentInfo _contentInfoWithout(
  final ContentInfo delegate, 
  final bool encodings,
  final bool languages,
  final bool length,
  final bool location,
  final bool mediaRange,
  final bool range) {
  
  if (encodings && languages && length && location && mediaRange && range) {
    return ContentInfo.NONE;
  }
  
  return new _ContentInfoImpl(
      !encodings ? Persistent.EMPTY_SEQUENCE.addAll(delegate.encodings) : Persistent.EMPTY_SEQUENCE,
      !languages ? Persistent.EMPTY_SET.addAll(delegate.languages) : Persistent.EMPTY_SET,
      !length ? delegate.length : Option.NONE,
      !location ? delegate.location : Option.NONE,
      !mediaRange ? delegate.mediaRange : Option.NONE,
      !range ? delegate.range : Option.NONE);
}

abstract class ContentInfo {
  static const ContentInfo NONE = const _ContentInfoNone();
  
  factory ContentInfo({
    final Iterable<ContentEncoding> encodings : const [],
    final Iterable<Language> languages : const [],
    final int length,
    final Uri location,
    final MediaRange mediaRange,
    final ContentRange range}) {
    
    if (isNull(encodings) && 
        isNull(languages) && 
        isNull(length) && 
        isNull(location) && 
        isNull(mediaRange) && 
        isNull(range)) {
      return ContentInfo.NONE;
    }
    return new _ContentInfoImpl(
        Persistent.EMPTY_SEQUENCE.addAll(encodings), 
        Persistent.EMPTY_SET.addAll(languages), 
        new Option(length), 
        new Option(location), 
        new Option(mediaRange), 
        new Option(range));
  }
  
  factory ContentInfo.wrapHeaders(final Multimap<Header, String, dynamic> headers) =>
      new _HeadersContentInfoImpl(headers);
      
  Sequence<ContentEncoding> get encodings;
  
  FiniteSet<Language> get languages;
  
  Option<int> get length;
  
  Option<Uri> get location;
  
  Option<MediaRange> get mediaRange;
  
  Option<ContentRange> get range;
  
  String toString();
  
  ContentInfo with_({
    Iterable<ContentEncoding> encodings,
    Iterable<Language> languages,
    int length,
    Uri location,
    MediaRange mediaRange,
    ContentRange range
  });
  
  ContentInfo without({
    bool encodings: false,
    bool languages: false,
    bool length: false,
    bool location: false,
    bool mediaRange:  false,
    bool range : false
  });
}

abstract class _ContentInfoMixin implements ContentInfo {
  String toString() =>
      _contentInfoToString(this);
  
  ContentInfo with_({
    final Iterable<ContentEncoding> encodings : const [],
    final Iterable<Language> languages : const [],
    final int length,
    final Uri location,
    final MediaRange mediaRange,
    final ContentRange range}) => 
        _contentInfoWith(this, encodings, languages, length, location, mediaRange, range);
  
  ContentInfo without({
    final bool encodings: false,
    final bool languages: false,
    final bool length: false,
    final bool location: false,
    final bool mediaRange:  false,
    final bool range : false}) => 
        _contentInfoWithout(this, encodings, languages, length, location, mediaRange, range);
}

class _ContentInfoNone implements ContentInfo {
  final ImmutableSequence<ContentEncoding> encodings = Persistent.EMPTY_SEQUENCE;
  final FiniteSet<Language> languages = Persistent.EMPTY_SET;
  final Option<int> length = Option.NONE;
  final Option<Uri> location = Option.NONE;
  final Option<MediaRange> mediaRange = Option.NONE;
  final Option<ContentRange> range = Option.NONE;
  
  const _ContentInfoNone();
  
  String toString() => "";
  
  ContentInfo with_({
    final Iterable<ContentEncoding> encodings: const [],
    final Iterable<Language> languages : const [],
    final int length,
    final Uri location,
    final MediaRange mediaRange,
    final ContentRange range}) => 
        new ContentInfo(
            encodings : encodings, 
            languages : languages, 
            length : length,
            location : location, 
            mediaRange : mediaRange, 
            range: range);
  
  ContentInfo without({
    final bool encodings: false,
    final bool languages: false,
    final bool length: false,
    final bool location: false,
    final bool mediaRange:  false,
    final bool range : false}) => 
        this;
}

abstract class ForwardingContentInfo implements Forwarder, ContentInfo {
  Sequence<ContentEncoding> get encodings =>
      delegate.encodings;
  
  FiniteSet<Language> get languages =>
      delegate.languages;
  
  Option<int> get length =>
      delegate.length;
  
  Option<Uri> get location =>
      delegate.location;
  
  Option<MediaRange> get mediaRange =>
      delegate.mediaRange;
  
  Option<ContentRange> get range =>
      delegate.range;
  
  String toString() =>
      _contentInfoToString(this);
  
  ContentInfo with_({
    final Iterable<ContentEncoding> encodings : const[],
    final Iterable<Language> languages : const[],
    final int length,
    final Uri location,
    final MediaRange mediaRange,
    final ContentRange range}) => 
        _contentInfoWith(this, encodings, languages, length, location, mediaRange, range);
  
  ContentInfo without({
    final bool encodings: false,
    final bool languages: false,
    final bool length: false,
    final bool location: false,
    final bool mediaRange:  false,
    final bool range : false}) =>
        _contentInfoWithout(this, encodings, languages, length, location, mediaRange, range);
}

class _ContentInfoImpl 
    extends Object
    with _ContentInfoMixin
    implements ContentInfo {
  final ImmutableSequence<ContentEncoding> encodings;
  final ImmutableSet<Language> languages;
  final Option<int> length;
  final Option<Uri> location;
  final Option<MediaRange> mediaRange;
  final Option<ContentRange> range;

  _ContentInfoImpl(this.encodings, this.languages, this.length, this.location, this.mediaRange, this.range);  
}

class _HeadersContentInfoImpl 
    extends Object 
    with _ContentInfoMixin,
      _Parseable
    implements ContentInfo {
  final Multimap<Header, String, dynamic> _headers;
  ImmutableSequence<ContentEncoding> _encodings;
  ImmutableSet<Language> _languages;
  Option<int> _length;
  Option<Uri> _location;
  Option<MediaRange> _mediaRange;
  Option<ContentRange> _range;

  _HeadersContentInfoImpl(this._headers);
  
  ImmutableSequence<ContentEncoding> get encodings =>
      computeIfNull(_encodings, () {
        _encodings = 
            _parse(CONTENT_ENCODING_HEADER, Header.CONTENT_ENCODING)
              .map((final Iterable<ContentEncoding> encodings) => 
                  Persistent.EMPTY_SEQUENCE.addAll(encodings))
              .orElse(Persistent.EMPTY_SEQUENCE);
            
        return _encodings;
      });
  
  ImmutableSet<Language> get languages =>
      computeIfNull(_languages, () {
        _languages = 
            _parse(CONTENT_LANGUAGE, Header.CONTENT_LANGUAGE)
              .map((final Iterable<Language> languages) => 
                  Persistent.EMPTY_SET.addAll(languages))
              .orElse(Persistent.EMPTY_SET);    
            
        return _languages;
      });
 
  Option<int> get length =>
      computeIfNull(_length, () {
        _length = _parse(INTEGER, Header.CONTENT_LENGTH);
        return _length;
      });
  
  Option<Uri> get location =>
      computeIfNull(_location, () {     
        _location = firstWhere(_headers.call(Header.CONTENT_LOCATION), (final String uri) => true)
            .flatMap(_parseUri);
        return _location;
      });
  
  Option<MediaRange> get mediaRange =>
      computeIfNull(_mediaRange, () {
        _mediaRange = _parse(MEDIA_RANGE, Header.CONTENT_TYPE);
        return _mediaRange;
      });
  
  Option<ContentRange> get range =>
      computeIfNull(_range, () {
        _range = _parse(CONTENT_RANGE, Header.CONTENT_RANGE);
        return _range;
      });
}