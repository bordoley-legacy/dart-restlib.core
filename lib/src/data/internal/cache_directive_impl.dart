part of data.internal;

final Parser<CacheDirective> CACHE_DIRECTIVE =
  KVP.map((final KeyValuePair kvp) {
    try {
      final int value = int.parse(kvp.e1);
      return new CacheDirective.createWithDigitValue(kvp.e0, value);
    } on FormatException{}

    return new CacheDirectiveImpl(kvp.e0.toLowerCase(), kvp.e1);
  });

class CacheDirectiveImpl extends IterableBase implements CacheDirective {
  final String e0;
  final String e1;

  const CacheDirectiveImpl(this.e0, this.e1);

  int get hashCode => computeHashCode([e0, e1]);
  Iterator get iterator => [e0, e1].iterator;

  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is Pair) {
      return this.e0 == other.e0 &&
          this.e1 == other.e1;
    } else {
      return false;
    }
  }

  String toString() =>
      e1.isEmpty ? e0 : "$e0=$e1";
}