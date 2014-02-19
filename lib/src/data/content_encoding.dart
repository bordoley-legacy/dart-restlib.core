part of restlib.core.data;

abstract class ContentEncoding implements Matcheable<ContentEncoding> {
  static const ANY = const ContentEncodingImpl("*");
}