part of restlib.core.data;

abstract class Charset implements Matcheable<Charset> {
  static final Parser<Charset> parser = CHARSET;

  static const Charset ANY = const CharsetImpl("*", Option.NONE);
  static const Charset ISO_8859_1 = const CharsetImpl("ISO-8859-1", const Option.constant(LATIN1));
  static const Charset US_ASCII  = const CharsetImpl("US-ASCII", const Option.constant(ASCII));
  static const Charset UTF_16 = const CharsetImpl("UTF-16", Option.NONE);
  static const Charset UTF_16BE = const CharsetImpl("UTF-16BE", Option.NONE);
  static const Charset UTF_16LE = const CharsetImpl("UTF-16LE", Option.NONE);
  static const Charset UTF_8 = const CharsetImpl("UTF-8", const Option.constant(UTF8));

  Option<Encoding> get codec;
}