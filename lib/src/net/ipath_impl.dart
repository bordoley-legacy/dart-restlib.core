part of restlib.core.net;

abstract class _IPathBase 
    extends Object
    with ForwardingIterable<String>,
      ForwardingAssociative<int, String>,
      ForwardingSequence<String>
    implements IPath {
  
  
  // FIXME: Should be const: https://code.google.com/p/dart/issues/detail?id=9745
  _IPathBase();
  
  Parser<String> get segmentParser;
  
  ImmutableSequence<String> get delegate;

  IPath get forwardSlashPath;

  int get hashCode =>
      delegate.hashCode;
  
  IPath get tail =>
      builder(delegate.tail);
  
  bool operator==(other) =>
      delegate == other;
  
  IPath add(final String segment) =>
      builder(delegate.add(segmentParser.parse(segment).value));
  
  IPath addAll(final Iterable<String> elements) =>
      builder(delegate.addAll(elements.map((final String segment) => 
          segmentParser.parse(segment).value)));
  
  IPath builder(final ImmutableSequence<String> delegate);
  
  IPath canonicalize() {
    IPath doCanonicalize() {
      if (this.isEmpty) {
        return forwardSlashPath;
      }

      if (this.length == 1) {
        return this.elementAt(0).isEmpty ? forwardSlashPath : this;
      } else if (this.length == 2) {
        if (this.every((final String segment) 
            => segment.isEmpty)) {
          return forwardSlashPath;
        } else if (this.elementAt(1).isEmpty) {
          return builder(EMPTY_SEQUENCE.addAll(this.take(1)));
        } else {
          return this;
        }           
      } else {
        final MutableSequence<String> buffer = new MutableFixedSizeSequence(this.length)..addAll(this);
      
        // Remove empty any empty segments between the first and last segment
        for (int i = 1; i < buffer.length - 1; i++) {
          if (buffer.elementAt(i).isEmpty) {
            buffer.removeAt(i);
            i--;
          }
        }
      
        if (equal(buffer, forwardSlashPath)) {
          return forwardSlashPath;
        }
      
        if (buffer.elementAt(buffer.length -1).isEmpty) {
          buffer.removeAt(buffer.length - 1);
        }
        
        return builder(EMPTY_SEQUENCE.addAll(buffer));
      }
    }
  
    final Sequence<String> canonical = doCanonicalize();
    
    if (this == canonical) {
      return this;
    } else {
      return canonical;
    }
}
  
  IPath remove(final String element) =>
      builder(delegate.remove(element));

  
  IPath push(final String segment) =>
      builder(delegate.push(segmentParser.parse(segment).value));
  
  IPath putAll(final Iterable<Pair<int, String>> other) =>
      builder(delegate.putAll(other.map((final Pair<int, String> pair) {
        segmentParser.parse(pair.snd).value;
        return pair;
      })));
  
  IPath putAllFromMap(final Map<int,String> map) {
    ImmutableSequence<String> newDelegate = this.delegate;
    map.forEach((final int key, final String value){
      newDelegate = newDelegate.put(key, segmentParser.parse(value).value);
    });
    
    return builder(newDelegate);
  }
  
  IPath put(final int key, final String value) =>
      builder(delegate.put(key, segmentParser.parse(value).value));
  
  IPath putPair(final Pair<int,String> pair) =>
      builder(delegate.put(pair.fst, segmentParser.parse(pair.snd).value));
  
  IPath removeAt(final int key) =>
      builder(delegate.removeAt(key));
  
  IPath pushAll(Iterable<String> value) =>
      builder(delegate.pushAll(value.map((final String value) => 
          segmentParser.parse(value).value)));
  
  String toString() =>
      this.join("/");
}