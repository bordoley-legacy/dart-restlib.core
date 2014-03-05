part of data;

abstract class ContentEncoding implements Matcheable<ContentEncoding> {
  static final Parser<ContentEncoding> parser = CONTENT_ENCODING;
  static const ANY = const ContentEncodingImpl("*");
}