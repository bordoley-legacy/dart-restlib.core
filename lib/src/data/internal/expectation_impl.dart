part of restlib.core.data.internal;

final Parser<Expectation> EXPECTATION =
  KVP.sepBy1(OWS_SEMICOLON_OWS)
    .map((final Iterable<KeyValuePair> kvp) =>
        new ExpectationImpl(EMPTY_SEQUENCE_MULTIMAP.putAll(kvp)));

class ExpectationImpl
    extends Object
    with ForwardingIterable<Pair<String,String>>,
      ForwardingAssociative<String, String>,
      ForwardingMultimap<String, String, Sequence<String>>
    implements Expectation {
  final ImmutableSequenceMultimap<String,String> delegate;

  ExpectationImpl(this.delegate);

  int get hashCode => delegate.hashCode;

  bool operator==(other) =>
      delegate == other;

  Expectation put(final String key, final String value) {
    checkArgument(TOKEN.parse(key).isNotEmpty);
    checkArgument(QUOTABLE.matchesAllOf(value));

    return new ExpectationImpl(delegate.put(key, value));
  }

  Expectation putAll(final Iterable<Pair<String, String>> other) =>
      other.fold(this, (final Expectation acc, final Pair<String, String> pair) =>
          acc.putPair(pair));

  Expectation putAllFromMap(Map<String, String> map) {
    Expectation retval = this;
    map.forEach((final String key, final String value) {
      retval = retval.put(key, value);
    });

    return retval;
  }

  Expectation putPair(Pair<String, String> pair) =>
      put(pair.fst, pair.snd);

  Expectation removeAt(final String key) =>
      new ExpectationImpl(delegate.removeAt(key));

  String toHeaderString() =>
      toString();

  String toString() =>
      pairIterableToString(this);
}