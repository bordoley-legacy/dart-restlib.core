part of restlib.core.data;

// FIXME: NPE when parsing "a=" kvp
final Parser<KeyValuePair> KVP =
  (TOKEN + _OPTIONAL_VALUE)
    .map((final Iterable elements) =>
      new KeyValuePair(elements.elementAt(0), elements.elementAt(1)));

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

class KeyValuePair extends Pair<String, String>  {    
  KeyValuePair(k,v): super(k,v);  
  
  String toString() =>
      _pairToString(this);
}