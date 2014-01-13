part of restlib.core.data;

final Parser<String> _WEAK_TAG = string(EntityTag._WEAK_TAG);
final Parser<EntityTag> ETAG = 
  (_WEAK_TAG.optional() + DQUOTE + ETAGC.many1().map(objectToString) + DQUOTE)
    .map((final Iterable e) => 
        e.elementAt(0).isEmpty ? 
            new EntityTag.strong(e.elementAt(2)) :
              new EntityTag.weak(e.elementAt(2)));

class EntityTag {
  static const String _WEAK_TAG = "W/";
  
  factory EntityTag.strong(final String value) {
    checkArgument(ETAGC.matchesAllOf(value));
    return new EntityTag._internal(value, false);
  }
  
  factory EntityTag.weak(final String value) {
    checkArgument(ETAGC.matchesAllOf(value));
    return new EntityTag._internal(value, true);
  }
      
  final String value;
  final bool isWeak;
  
  const EntityTag._internal(this.value, this.isWeak);
  
  int get hashCode => computeHashCode([value, isWeak]);
  
  bool operator==(other){
    if (identical(this,other)) {
      return true;
    } else if(other is EntityTag) {
      return this.value == other.value &&
          this.isWeak == other.isWeak;
    } else {
      return false;
    }
  }
  
  String toString() =>
    "${isWeak ? _WEAK_TAG : ""}\"${encodeQuotedString(value)}\"";
}