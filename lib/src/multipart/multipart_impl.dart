part of restlib.core.multipart;

class _Multipart<T>
    extends Object
    with ForwardingIterable<Part<T>>
    implements Multipart<T> {
  final String boundary;    
  final Iterable<Part<T>> delegate;
    
  _Multipart(this.boundary, this.delegate);
}    

class _PartContentInfo 
    extends Object
    with ForwardingContentInfo
    implements PartContentInfo {
  final ImmutableDictionary<Header, dynamic> customHeaders;
  final ContentInfo delegate;
  
  _PartContentInfo(this.customHeaders, this.delegate);
  
  PartContentInfo with_({
    final Dictionary<Header, dynamic> customHeaders,
    final Iterable<ContentEncoding> encodings,
    final Iterable<Language> languages,
    final int length,
    final URI location,
    final MediaRange mediaRange,
    final ContentRange range 
  }) {
    final ContentInfo delegate = 
        this.delegate.with_(
            encodings: encodings, 
            languages: languages, 
            length: length, 
            location: location, 
            mediaRange: mediaRange, 
            range: range);
    return new _PartContentInfo(Persistent.EMPTY_DICTIONARY.putAll(customHeaders), delegate);
  }
  
  ContentInfo without({
    final bool customHeaders: false,
    final bool encodings: false,
    final bool languages: false,
    final bool length: false,
    final bool location: false,
    final bool mediaRange:  false,
    final bool range : false
  }) {
    final ContentInfo delegate =
        this.delegate.without(
            encodings: encodings, 
            languages: languages, 
            length: length, 
            location: location, 
            mediaRange: mediaRange, 
            range: range);
    final ImmutableDictionary<Header, dynamic> newCustomHeaders =
        !customHeaders ? this.customHeaders : Persistent.EMPTY_DICTIONARY;
    return new _PartContentInfo (newCustomHeaders, delegate);
  }
}