part of data;

abstract class EntityTag {
  static final Parser<EntityTag> parser = ETAG;

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