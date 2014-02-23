part of restlib.core.data;

abstract class Expectation implements ImmutableSequenceMultimap<String,String> {
  static final Parser<Expectation> parser = EXPECTATION;

  static final Expectation EXPECTS_100_CONTINUE =
      new ExpectationImpl(
          EMPTY_SEQUENCE_MULTIMAP.put("100-continue",""));

  ImmutableSequence<String> call(String key);
  Expectation put(final String key, final String value);
  Expectation putAll(final Iterable<Pair<String, String>> other);
  Expectation putAllFromMap(Map<String, String> map);
  Expectation putPair(Pair<String, String> pair);
  Expectation removeAt(final String key);
}