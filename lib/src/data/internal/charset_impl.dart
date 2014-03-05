part of data.internal;

final PatternMatcher<Charset> _charsetMatcher =
  new PatternMatcher<Charset>(
    [inCaseOf(equals(Charset.ANY.toString()), (_) => Charset.ANY),
     inCaseOf(equals(Charset.UTF_8.toString()), (_) => Charset.UTF_8),
     inCaseOf(equals(Charset.US_ASCII.toString()), (_) => Charset.US_ASCII),
     inCaseOf(equals(Charset.ISO_8859_1.toString()), (_) => Charset.ISO_8859_1),
     inCaseOf(equals(Charset.UTF_16.toString()), (_) => Charset.UTF_16),
     inCaseOf(equals(Charset.UTF_16BE.toString()), (_) => Charset.UTF_16BE),
     inCaseOf(equals(Charset.UTF_16LE.toString()), (_) => Charset.UTF_16LE),
     otherwise((final String charsetName) => 
         new CharsetImpl(charsetName, Option.NONE))
     ]);

final Parser<Charset> CHARSET = 
  TOKEN.flatMap((final String charsetName) =>
      _charsetMatcher(charsetName.toUpperCase()));

class CharsetImpl implements Charset {  
  final String _charset;
  final Option<Encoding> codec; 
  
  const CharsetImpl(this._charset, this.codec);
  
  int get hashCode => 
      _charset.hashCode;
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if(other is Charset) {
      return this.toString() == other.toString();
    } else {
      return false;
    }
  }
  
  int match(final Charset that) {
    if (this == that) {
      return 1000;
    } else if (this == Charset.ANY) {
      return 500;
    } else {
      return 0;
    }
  }
  
  String toString() =>
      _charset;
}