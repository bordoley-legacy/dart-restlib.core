part of restlib.core.data;

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
         new Charset._internal(charsetName, Option.NONE))
     ]);

final Parser<Charset> CHARSET = 
  TOKEN.flatMap((final String charsetName) =>
      _charsetMatcher(charsetName.toUpperCase()));

class Charset implements Matcheable<Charset> {
  static const Charset ANY = const Charset._internal("*", Option.NONE);
  static const Charset ISO_8859_1 = const Charset._internal("ISO-8859-1", const Option.constant(LATIN1));
  static const Charset US_ASCII  = const Charset._internal("US-ASCII", const Option.constant(ASCII));
  static const Charset UTF_16 = const Charset._internal("UTF-16", Option.NONE);
  static const Charset UTF_16BE = const Charset._internal("UTF-16BE", Option.NONE);
  static const Charset UTF_16LE = const Charset._internal("UTF-16LE", Option.NONE);
  static const Charset UTF_8 = const Charset._internal("UTF-8", const Option.constant(UTF8));
  
  final String _charset;
  final Option<Encoding> codec; 
  
  const Charset._internal(this._charset, this.codec);
  
  int get hashCode => computeHashCode([_charset]);
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if(other is Charset) {
      return this._charset == other._charset;
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
  
  String toString() => _charset;
}