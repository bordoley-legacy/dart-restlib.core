part of restlib.core.data;

// FIXME: NPE when parsing "a=" kvp
final Parser<KeyValuePair> KVP =
  (TOKEN + _OPTIONAL_VALUE)
    .map((final Iterable elements) =>
      new KeyValuePair._internal(elements.elementAt(0), elements.elementAt(1)));

final Parser<String> _OPTIONAL_VALUE =
  (OWS + EQUALS + OWS + OPTIONAL_WORD)
    .map((final Iterable elements) => 
        elements.elementAt(3))
    .orElse("");

final Parser<KeyValuePair> KVP_NOT_Q =
  KVP.map((final KeyValuePair kvp) =>
    (kvp.fst.toLowerCase() != "q") ? kvp : null);

String pairIterableToString(final Iterable<Pair> entries) => 
    entries.map(_pairToString).join(";"); 

String _pairToString(final Pair pair) {
  final String value = pair.snd.toString();
  if (value.isEmpty) {
    return pair.fst.toString();
  } else {
    return "${pair.fst.toString()}=${value}";
  }
}

class KeyValuePair implements Pair<String, String>  {   
  final Pair<String, String> _delegate;
   
  KeyValuePair._internal(final String fst, final String snd) : 
     _delegate = new Pair(fst, snd);
   
  KeyValuePair._wrap(this._delegate);

  String get fst =>
      _delegate.fst;
  
  String get snd =>
      _delegate.snd;
  
  int get hashCode =>
      _delegate.hashCode;
  
  bool operator==(other) =>
      _delegate == other;
  
  String toString() =>
      "$fst=$snd";
}