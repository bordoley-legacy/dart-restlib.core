part of restlib.core.data;

//final Parser<Form> FORM ;
/*
class Form 
    extends _MultimapForwarder {
  
  // FIXME: Ideally this would const, but dart doesn't yet allow using mixins with const
  // see: https://code.google.com/p/dart/issues/detail?id=9745  
  static final Form EMPTY = new Form._internal(PersistentSequenceMultimap.EMPTY);
  
  final PersistentSequenceMultimap<String, String> delegate;
  
  // FIXME: Ideally this would const, but dart doesn't yet allow using mixins with const
  // see: https://code.google.com/p/dart/issues/detail?id=9745  
  Form._internal(delegate):
    this.delegate = delegate,
    super(delegate);
  
  int get hashCode =>
      delegate.hashCode;
  
  bool equals(final other) {
    if (identical(this, other)) {
      return true;
    } else if (other is Form) {
      return this.delegate == (other as Form).delegate;
    } else {
      return false;
    }
  }
  
  Form insert(final String key, final String value) {
    checkArgument(!key.isEmpty); 
    return new Form._internal(delegate.insert(key, value));
  }
  
  Form insertPair(final Pair<String, String> pair) =>
      insert(pair.fst, pair.snd);
  
  Form insertAll(final Iterable<Pair<String, String>> pairs) =>
      pairs.fold(this, (final Form accumulator, final Pair<String, String> pair) =>
          accumulator.insertPair(pair));
  
  Form removeAt(final String key) =>
      new Form._internal(delegate.removeAt(key));
  
  String toString() => 
      delegate.toString();
}
// FIXME: Work around https://code.google.com/p/dart/issues/detail?id=14453    
class _MultimapForwarder 
    extends ForwardingMultimap<String, String, dynamic>  
    with  
      ForwardingIterable<Pair<String,String>>,
      ForwardingAssociative<String,String> {
  
  final Multimap<String, String, dynamic> delegate;
  
  _MultimapForwarder(this.delegate);
}*/