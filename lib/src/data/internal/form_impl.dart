part of restlib.core.data.internal;

final Parser<Form> FORM = 
  _FORM_PAIR.sepBy(AMPERSAND).map((final Iterable<Pair<String, String>> pairs) =>
      Form.EMPTY.putAll(pairs));

// http://url.spec.whatwg.org/#concept-urlencoded-parser
final Parser<Pair<String, String>> _FORM_PAIR = 
  AMPERSAND.negate().many().map((final IterableString pairItr) {
    final String pair = pairItr.toString().replaceAll("+", "%20");
    final int sepLoc = pair.toString().indexOf("=");
    
    String key = "";
    String value = "";
    if (sepLoc > -1) {
      key = pair.substring(0, sepLoc);
    }
    
    if (sepLoc < pair.length -2 ); {
      value = pair.substring(sepLoc +1);
    }
    
    return new Pair(_FORM_CODEC.decode(key), _FORM_CODEC.decode(value));
  });

final Codec<String,String> _FORM_CODEC = utf8codec(QUERY_SAFE_CHARS.matches);

class FormImpl
    extends Object
    with ForwardingMultimap<String, String, Multiset<String>>,
      ForwardingAssociative<String, String>,
      ForwardingIterable<Pair<String, String>>
    implements Form {
  final ImmutableMultisetMultimap<String, String> delegate;
  
  // FIXME: Should be const: https://code.google.com/p/dart/issues/detail?id=9745
  FormImpl(this.delegate);
  
  // FIXME: Should be const: https://code.google.com/p/dart/issues/detail?id=9745
  FormImpl.empty() :
    this.delegate = EMPTY_MULTISET_MULTIMAP;
  
  int get hashCode =>
      delegate.hashCode;
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } 
    
    return delegate == other;
  }
  
  Form put(final String key, final String value) =>
      new FormImpl(delegate.put(key, value));
  
  Form putAll(final Iterable<Pair<String, String>> other) =>
      other.isEmpty ? this : new FormImpl(delegate.putAll(other));
  
  Form putAllFromMap(final Map<String, String> map) =>
      map.isEmpty ? this : new FormImpl(delegate.putAllFromMap(map));
  
  Form putPair(final Pair<String, String> pair) =>
      new FormImpl(delegate.putPair(pair));
  
  Form removeAt(final String key) =>
      delegate.dictionary[key]
        .map((_) => new FormImpl(delegate.removeAt(key)))
        .orElse(this);
  
  String toString() =>
      map((final Pair<String, String> pair) => 
          "${_FORM_CODEC.encode(pair.fst)}=${_FORM_CODEC.encode(pair.snd)}".replaceAll("%20", "+")).join("&");
}