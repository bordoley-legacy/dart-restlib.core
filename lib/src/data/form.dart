part of restlib.core.data;

abstract class Form implements ImmutableMultisetMultimap<String, String> {
  static Parser<Form> parser = FORM;

  // FIXME: Should be const: https://code.google.com/p/dart/issues/detail?id=9745
  static final  Form EMPTY = new FormImpl.empty();

  Form put(final String key, final String value);
  Form putAll(final Iterable<Pair<String, String>> other);
  Form putAllFromMap(final Map<String, String> map);
  Form putPair(final Pair<String, String> pair);
  Form removeAt(final String key);
}

