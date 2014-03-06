part of data.internal;

// FIXME: NPE when parsing "a=" kvp
final Parser<KeyValuePair> KVP =
  (TOKEN + _OPTIONAL_VALUE)
    .map((final Pair<String, String> e) =>
      new KeyValuePair._internal(e.e0, e.e1));

final Parser<String> _OPTIONAL_VALUE =
  (OWS + EQUALS + OWS + OPTIONAL_WORD)
    .map((final Tuple4<IterableString, int, IterableString, String> e) => e.e3)
    .orElse("");

final Parser<KeyValuePair> KVP_NOT_Q =
  KVP.map((final KeyValuePair kvp) =>
    (kvp.e0.toLowerCase() != "q") ? kvp : null);

String pairIterableToString(final Iterable<Pair> entries) =>
    entries.map(_pairToString).join(";");

String _pairToString(final Pair pair) {
  final String value = pair.e1.toString();
  if (value.isEmpty) {
    return pair.e0.toString();
  } else {
    return "${pair.e0.toString()}=${value}";
  }
}

class KeyValuePair extends Object with ForwardingIterable implements Pair<String, String>  {
  final Pair<String, String> delegate;

  KeyValuePair._internal(final String fst, final String snd) :
     delegate = new Pair(fst, snd);

  KeyValuePair._wrap(this.delegate);

  String get e0 =>
      delegate.e0;

  String get e1 =>
      delegate.e1;

  int get hashCode =>
      delegate.hashCode;

  bool operator==(other) =>
      delegate == other;

  String toString() =>
      "$e0=$e1";
}