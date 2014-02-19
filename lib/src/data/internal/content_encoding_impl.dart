part of restlib.core.data.internal;

final Parser<ContentEncoding> CONTENT_ENCODING =
  TOKEN.map((final String encoding) => 
      new ContentEncodingImpl(encoding.toLowerCase()));

class ContentEncodingImpl implements ContentEncoding {  
  final String _contentEncoding;
  
  const ContentEncodingImpl(this._contentEncoding);
  
  int get hashCode => 
      _contentEncoding.hashCode;
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if(other is ContentEncoding) {
      return this.toString() == other.toString();
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
  
  String toString() => 
      _contentEncoding;
}