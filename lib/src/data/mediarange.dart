part of restlib.core.data;

final Parser<Iterable<KeyValuePair>> _PARAMETERS = 
(OWS_SEMICOLON_OWS + KVP_NOT_Q.sepBy(OWS_SEMICOLON_OWS))
  .map((final Iterable e) => 
      e.elementAt(1))
  .orElse(EMPTY_LIST);

final Parser<MediaRange> MEDIA_RANGE =
  (TOKEN + FORWARD_SLASH + TOKEN + _PARAMETERS)
    .map((final Iterable e) {
      final String type = e.elementAt(0).toLowerCase();
      final String subtype = e.elementAt(2).toLowerCase();
      Option<Charset> charset = Option.NONE;
      final SetMultimap<String, String> parameters = 
          Persistent.EMPTY_SET_MULTIMAP.insertAll(
              e.elementAt(3).where((final KeyValuePair kvp) {                
                final String key = kvp.fst.toLowerCase();
                
                // Parse the first valid charset in the parameters. Skip the rest.
                if (key == "charset") {
                  if (charset.isEmpty) {
                    charset = CHARSET.parse(kvp.snd);
                    charset = (charset.isNotEmpty && (charset.value == Charset.ANY)) ?
                      Option.NONE : charset;
                  }
                  
                  return false;
                } else {
                  return true;
                }
              }));
      
      return new MediaRange._internal(type, subtype, charset, parameters); 
    });


class MediaRange implements Matcheable<MediaRange> {  
  static const MediaRange ANY = const MediaRange._internal("*", "*");
  static const MediaRange APPLICATION_ANY = const MediaRange._internal("application", "*");
  static const MediaRange APPLICATION_ATOM = const MediaRange._internal("application", "atom+xml");
  static final MediaRange APPLICATION_ATOM_ENTRY = MEDIA_RANGE.parse("application/atom+xml;type=entry").value;
  static final MediaRange APPLICATION_ATOM_FEED = MEDIA_RANGE.parse("application/atom+xml;type=feed").value;
  static const MediaRange APPLICATION_JSON = const MediaRange._internal("application", "json");
  static final MediaRange APPLICATION_JSON_ENTRY = MEDIA_RANGE.parse("application/json;type=entry").value;
  static final MediaRange APPLICATION_JSON_FEED = MEDIA_RANGE.parse("application/json;type=feed").value;
  static const MediaRange APPLICATION_OCTET_STREAM = const MediaRange._internal("application", "octet-stream");
  static const MediaRange APPLICATION_OPEN_SEARCH_DESCRIPTION_XML = const MediaRange._internal("application", "opensearchdescription+xml");
  static const MediaRange APPLICATION_WWW_FORM = const MediaRange._internal("application", "x-www-form-urlencoded");
  static const MediaRange APPLICATION_XML = const MediaRange._internal("application", "xml");
  static const MediaRange GOOGLE_PROTOCOL_BUFFER = const MediaRange._internal("application", "x-protobuf");
  static const MediaRange MULTIPART_BYTE_RANGE = const MediaRange._internal("multipart", "byteranges");
  static const MediaRange MULTIPART_FORM_DATA = const MediaRange._internal("multipart", "form-data");
  static const MediaRange MULTIPART_RELATED = const MediaRange._internal("multipart" , "related");
  static const MediaRange TEXT_ANY = const MediaRange._internal("text", "*");
  static const MediaRange TEXT_HTML = const MediaRange._internal("text", "html");
  static final MediaRange TEXT_HTML_ENTRY = MEDIA_RANGE.parse("text/html;type=entry").value;
  static final MediaRange TEXT_HTML_FEED = MEDIA_RANGE.parse("text/html;type=feed").value;
  static const MediaRange TEXT_PLAIN = const MediaRange._internal("text", "plain");     

  factory MediaRange(final String type, final String subtype, {final Charset charset, Multimap<String,String, dynamic> parameters}) {
    checkArgument(TOKEN.parse(type).isNotEmpty);
    checkArgument(TOKEN.parse(subtype).isNotEmpty);
    Option<Charset> optionalCharset = new Option(charset);
    
    optionalCharset.map((final Charset charset) => 
        checkArgument(charset != Charset.ANY));
    
    parameters = firstNotNull(parameters, Persistent.EMPTY_SET_MULTIMAP);
    parameters = 
        Persistent.EMPTY_SET_MULTIMAP.insertAll(
            parameters.map((final Pair<String,String> kv) {
              checkArgument(TOKEN.parse(kv.fst).isNotEmpty);
              checkArgument(kv.fst.toLowerCase() != "q");
              checkArgument(kv.fst.toLowerCase() != "charset");
              checkArgument(QUOTABLE.matchesAllOf(kv.snd));
              return new Pair(kv.fst.toLowerCase(), kv.snd);
            }));
    
    return new MediaRange._internal(
        type.toLowerCase(), subtype.toLowerCase(), optionalCharset, parameters);
  }
  
  final Option<Charset> charset;
  final String type;
  final String subtype;
  final Multimap<String, String, dynamic> parameters;
  
  const MediaRange._internal(this.type, this.subtype, [this.charset = Option.NONE, this.parameters = Persistent.EMPTY_SET_MULTIMAP]);
  
  int get hashCode =>
      computeHashCode([type, subtype, charset, parameters]);
  
  int match(final MediaRange that) {
    //if(this.charset.isDefined) { 
    //  throw new StateError("Invalid to call match on MediaRange with a defined charset."); 
    //}

    if (this == that) {
      return 1000;
    } else if (this == MediaRange.ANY) {
      return 250;
    } else if (this.type != that.type) {
      return 0;            
    } else if (this.subtype =="*") {
      return 500;
    } else if (this.subtype != that.subtype) {
      return 0;
    } else if (this.parameters == that.parameters) {
      return 1000;
    } else if (that.parameters.every((ele) => this.parameters.contains(ele))) {
      return 750;
    } else {
      return 0;
    }
  }
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is MediaRange) {
      return (this.type == other.type) &&
          (this.subtype == other.subtype) &&
          (this.charset == other.charset) &&
          (this.parameters == other.parameters);
    } else {
      return false;
    }
  }
  
  MediaRange with_({final Charset charset, final Multimap<String, String, dynamic> parameters}) {
    checkState((type != "*") && (subtype != "*"));
    checkArgument(charset != Charset.ANY);

    final Charset newCharset = computeIfNull(charset, () => this.charset.nullableValue);
    final Multimap<String, String, dynamic> newParameters = firstNotNull(parameters, this.parameters);
    
    return new MediaRange(this.type, this.subtype, charset: newCharset, parameters: newParameters);
  }
  
  String toString() {        
    StringBuffer buffer = new StringBuffer();
    buffer
      ..write(this.type)
      ..write('/')
      ..write(this.subtype);
    
    this.charset.map(
        (final Charset charset) => 
            buffer
              ..write("; ")
              ..write("charset")
              ..write('=')
              ..write(charset));
    
    if (!this.parameters.isEmpty) {
      buffer
        ..write("; ")
        ..write(pairIterableToString(this.parameters));
    }
    
    return buffer.toString();
  }
}