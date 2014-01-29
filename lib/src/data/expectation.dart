part of restlib.core.data;

final Parser<Expectation> EXPECTATION =
  KVP.sepBy1(OWS_SEMICOLON_OWS)
    .map((final Iterable<KeyValuePair> kvp) =>
        new Expectation._internal(Persistent.EMPTY_SEQUENCE_MULTIMAP.putAll(kvp)));

class Expectation {
  static final Expectation EXPECTS_100_CONTINUE = 
      new Expectation._internal(
          Persistent.EMPTY_SEQUENCE_MULTIMAP.put("100-continue",""));
  
  final Multimap<String, String, dynamic> expectations;
  
  const Expectation._internal(this.expectations);
  
  int get hashCode => computeHashCode([expectations]);
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if(other is Expectation) {
      return this.expectations == other.expectations;
    } else {
      return false;
    }
  }
  
  String toString() =>
      pairIterableToString(expectations);
}