part of restlib.core.data;

abstract class Form implements ImmutableMultisetMultimap<String, String>, Persistent {
  static const Form EMPTY = const _FormImpl.empty();
  
  Form put(final String key, final String value);
  Form putAll(final Iterable<Pair<String, String>> other);
  Form putAllFromMap(final Map<String, String> map);
  Form putPair(final Pair<String, String> pair);
  Form removeAt(final String key);
}

class _FormImpl
    extends Object
    with ForwardingMultimap<String, String, Multiset<String>>,
      ForwardingAssociative<String, String>,
      ForwardingIterable<Pair<String, String>>
    implements Form {
  final ImmutableMultisetMultimap<String, String> delegate;
  
  const _FormImpl(this.delegate);
  
  const _FormImpl.empty() :
    this.delegate = Persistent.EMPTY_MULTISET_MULTIMAP;
  
  int get hashCode =>
      delegate.hashCode;
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } 
    
    return delegate == other;
  }
  
  Form put(final String key, final String value) =>
      new _FormImpl(delegate.put(key, value));
  
  Form putAll(final Iterable<Pair<String, String>> other) =>
      other.isEmpty ? this : new _FormImpl(delegate.putAll(other));
  
  Form putAllFromMap(final Map<String, String> map) =>
      map.isEmpty ? this : new _FormImpl(delegate.putAllFromMap(map));
  
  Form putPair(final Pair<String, String> pair) =>
      new _FormImpl(delegate.putPair(pair));
  
  Form removeAt(final String key) =>
      delegate.dictionary[key]
        .map((_) => new _FormImpl(delegate.removeAt(key)))
        .orElse(this);
  
  String toString() =>
      "FIXME: implement";
}