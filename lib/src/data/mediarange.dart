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
          Persistent.EMPTY_SET_MULTIMAP.putAll(
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
  static const MediaRange TEXT_ANY = const MediaRange._internal("text", "*");

  factory MediaRange(final String type, final String subtype, {final Charset charset, Multimap<String,String, dynamic> parameters}) {
    checkArgument(TOKEN.parse(type).isNotEmpty);
    checkArgument(TOKEN.parse(subtype).isNotEmpty);
    Option<Charset> optionalCharset = new Option(charset);
    
    optionalCharset.map((final Charset charset) => 
        checkArgument(charset != Charset.ANY));
    
    parameters = firstNotNull(parameters, Persistent.EMPTY_SET_MULTIMAP);
    parameters = 
        Persistent.EMPTY_SET_MULTIMAP.putAll(
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
  
  // FIXME: Making this public so that we can have a library of media ranges. Maybe this should be in a internal library
  // where we can strictly define the limits of use.
  const MediaRange.constant(this.type, this.subtype) :
    this.charset = Option.NONE,
    this.parameters = Persistent.EMPTY_SET_MULTIMAP;
  
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