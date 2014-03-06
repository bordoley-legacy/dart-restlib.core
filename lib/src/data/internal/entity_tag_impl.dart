part of data.internal;

const String _WEAK_TAG_STR = "W/";

final Parser<String> _WEAK_TAG = string(_WEAK_TAG_STR);
final Parser<EntityTag> ETAG =
  (_WEAK_TAG.optional() + DQUOTE + ETAGC.many1().map(objectToString) + DQUOTE)
    .map((final Tuple4<Option<String>, int, String, int> e) =>
        e.e0.isEmpty ?
            new EntityTag.strong(e.e2) :
              new EntityTag.weak(e.e2));

class EntityTagImpl implements EntityTag {
  final String value;
  final bool isWeak;

  const EntityTagImpl(this.value, this.isWeak);

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
    "${isWeak ? _WEAK_TAG_STR : ""}${encodeQuotedString(value)}";
}