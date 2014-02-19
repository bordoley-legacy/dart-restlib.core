part of restlib.core.data;

abstract class EntityTag {
  factory EntityTag.strong(final String value) {
    checkArgument(ETAGC.matchesAllOf(value));
    return new EntityTagImpl(value, false);
  }
  
  factory EntityTag.weak(final String value) {
    checkArgument(ETAGC.matchesAllOf(value));
    return new EntityTagImpl(value, true);
  }
  
  String get value;
  bool get isWeak;
}