part of restlib.core.data;

final Parser<ContentEncoding> CONTENT_ENCODING =
  TOKEN.map((final String encoding) => 
      new ContentEncoding._internal(encoding.toLowerCase()));

class ContentEncoding implements Matcheable<ContentEncoding> {
  static const ANY = const ContentEncoding._internal("*");
  
  final String _contentEncoding;
  
  const ContentEncoding._internal(this._contentEncoding);
  
  int get hashCode => computeHashCode([_contentEncoding]);
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if(other is ContentEncoding) {
      return this._contentEncoding == other._contentEncoding;
    } else {
      return false;
    }
  }
  
  int match(final ContentEncoding that) {
    if (this == that) {
      return 1000;
    } else if (this == ContentEncoding.ANY) {
      return 500;
    } else {
      return 0;
    }
  }
  
  String toString() => _contentEncoding;
}