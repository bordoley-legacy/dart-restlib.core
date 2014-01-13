part of restlib.core.http;

abstract class ContentInfo {
  static const ContentInfo NONE = const _ContentInfoNone();

  // The encodings applied to the content in order.
  ImmutableSequence<ContentEncoding> get encodings;
  ImmutableSet<Language> get languages;
  Option<int> get length;
  Option<Uri> get location;
  Option<MediaRange> get mediaRange;
  Option<ContentRange> get range;
  
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

class _ContentInfoNone implements ContentInfo {
  final ImmutableSequence<ContentEncoding> encodings = Persistent.EMPTY_SEQUENCE;
  final ImmutableSet<Language> languages = Persistent.EMPTY_SET;
  final Option<int> length = Option.NONE;
  final Option<Uri> location = Option.NONE;
  final Option<MediaRange> mediaRange = Option.NONE;
  final Option<ContentRange> range = Option.NONE;
  
  const _ContentInfoNone();
  
  ContentInfo with_({
    final Iterable<ContentEncoding> encodings,
    final Iterable<Language> languages,
    final int length,
    final Uri location,
    final MediaRange mediaRange,
    final ContentRange range
  }) => new _ContentInfoImpl._with(this, 
      encodings: encodings, 
      languages: languages, 
      length: length, 
      location: location, 
      mediaRange: mediaRange, 
      range: range);
  
  ContentInfo without({
    final bool encodings: false,
    final bool languages: false,
    final bool length: false,
    final bool location: false,
    final bool mediaRange:  false,
    final bool range : false
  }) => new _ContentInfoImpl._without(this, 
      encodings: encodings, 
      languages: languages, 
      length: length, 
      location: location, 
      mediaRange: mediaRange, 
      range: range);
  
  String toString() => "";
}

abstract class ForwardingContentInfo implements Forwarder, ContentInfo {
  ImmutableSequence<ContentEncoding> get encodings =>
      delegate.encodings;
  
  ImmutableSet<Language> get languages =>
      delegate.langugages;
  
  Option<int> get length =>
      delegate.length;
  
  Option<Uri> get location =>
      delegate.location;
  
  Option<MediaRange> get mediaRange =>
      delegate.mediaRange;
  
  Option<ContentRange> get range =>
      delegate.range;
}

abstract class ContentInfoWith_ implements ContentInfo {
  ContentInfo with_({
    final Iterable<ContentEncoding> encodings,
    final Iterable<Language> languages,
    final int length,
    final Uri location,
    final MediaRange mediaRange,
    final ContentRange range
  }) => new _ContentInfoImpl._with(this, 
      encodings: encodings, 
      languages: languages, 
      length: length, 
      location: location, 
      mediaRange: mediaRange, 
      range: range);
  
  ContentInfo without({
    final bool encodings: false,
    final bool languages: false,
    final bool length: false,
    final bool location: false,
    final bool mediaRange:  false,
    final bool range : false
  })  => new _ContentInfoImpl._without(this, 
      encodings: encodings, 
      languages: languages, 
      length: length, 
      location: location, 
      mediaRange: mediaRange, 
      range: range);
}

class ContentInfoBuilder {
  MutableSequence<ContentEncoding> _encodings = new GrowableSequence();
  MutableSet<Language> _languages = new MutableSet.hash();
  Option<int> _length = Option.NONE;
  Option<Uri> _location = Option.NONE;
  Option<MediaRange> _mediaRange = Option.NONE;
  Option<ContentRange> _range  = Option.NONE;
  
  set length (final int length) => 
      this._length = new Option(length);
  
  set location(final Uri location) => 
      this._location = new Option(location);

  set mediaRange (final MediaRange mediaRange) =>
    this._mediaRange = new Option(mediaRange);
  
  set range(final ContentRange range) =>
      this._range = new Option(range);
  
  void addEncoding(final ContentEncoding encoding) => 
      this._encodings.add(encoding);
  
  void addEncodings(final Iterable<ContentEncoding> encodings) =>
    this._encodings.addAll(encodings);
  
  void addLanguage(final Language language) =>
      this._languages.add(language);
  
  void addLanguages(final Iterable<Language> languages) => 
      this._languages.addAll(languages);

  ContentInfo build() => new _ContentInfoImpl(this);
}

class _ContentInfoImpl 
    extends Object 
    with ContentInfoToString, 
      ContentInfoWith_
    implements ContentInfo {
  final ImmutableSequence<ContentEncoding> encodings;
  final ImmutableSet<Language> languages;
  final Option<int> length;
  final Option<Uri> location;
  final Option<MediaRange> mediaRange;
  final Option<ContentRange> range;

  _ContentInfoImpl(final ContentInfoBuilder builder) :
    encodings = Persistent.EMPTY_SEQUENCE.addAll(builder._encodings),
    languages = Persistent.EMPTY_SET.addAll(builder._languages),
    length = builder._length,
    location = builder._location,
    mediaRange = builder._mediaRange,
    range = builder._range;
  
  _ContentInfoImpl._with(final ContentInfo delegate,{
    final Iterable<ContentEncoding> encodings,
    final Iterable<Language> languages,
    final int length,
    final Uri location,
    final MediaRange mediaRange,
    final ContentRange range
  }) :
    this.encodings = computeIfNotNullOtherwise(encodings, delegate.encodings, Persistent.EMPTY_SEQUENCE.addAll),
    this.languages = computeIfNotNullOtherwise(languages, delegate.languages, Persistent.EMPTY_SET.addAll),
    this.length = computeIfEmpty(new Option(length), () => delegate.length),
    this.location = computeIfEmpty(new Option(location), () => delegate.location),
    this.mediaRange = computeIfEmpty(new Option(mediaRange), () => delegate.mediaRange),
    this.range = computeIfEmpty(new Option(range), () => delegate.range);
  
  _ContentInfoImpl._without(final ContentInfo delegate,{
    final bool encodings,
    final bool languages,
    final bool length,
    final bool location,
    final bool mediaRange,
    final bool range
  }) :
    this.encodings = !encodings ? delegate.encodings : Persistent.EMPTY_SEQUENCE,
    this.languages = !languages ? delegate.languages : Persistent.EMPTY_SET,
    this.length = !length ? delegate.length : Option.NONE,
    this.location = !location ? delegate.location : Option.NONE,
    this.mediaRange = !mediaRange ? delegate.mediaRange : Option.NONE,
    this.range = !range ? delegate.range : Option.NONE;
}

abstract class ContentInfoToString implements ContentInfo {
  String toString() => 
      (new StringBuffer()
        ..write(Header.CONTENT_ENCODING.write(encodings))
        ..write(Header.CONTENT_LANGUAGE.write(languages))
        ..write(Header.CONTENT_LENGTH.write(length))
        ..write(Header.CONTENT_LOCATION.write(location))
        ..write(Header.CONTENT_TYPE.write(mediaRange))
        ..write(Header.CONTENT_RANGE.write(range))
      ).toString();
}