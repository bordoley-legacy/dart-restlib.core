part of data.internal;

final Parser<CacheDirective> CACHE_DIRECTIVE =
  KVP.map((final KeyValuePair kvp) { 
    try {
      final int value = int.parse(kvp.snd);
      return new CacheDirective.createWithDigitValue(kvp.fst, value);
    } on FormatException{}
    
    return new CacheDirectiveImpl(kvp.fst.toLowerCase(), kvp.snd);
  });

class CacheDirectiveImpl implements CacheDirective {
  final String fst;
  final String snd;
  
  const CacheDirectiveImpl(this.fst, this.snd);
  
  int get hashCode => computeHashCode([fst, snd]);
    
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is Pair) {
      return this.fst == other.fst &&
          this.snd == other.snd;
    } else {
      return false;
    }
  }
  
  String toString() => 
      snd.isEmpty ? fst : "$fst=$snd";
}