part of restlib.core.data;

abstract class MediaRange implements Matcheable<MediaRange> {
  static const MediaRange ANY = const MediaRangeImpl.constant("*", "*");
  static const MediaRange APPLICATION_ANY = const MediaRangeImpl.constant("application", "*");
  static const MediaRange TEXT_ANY = const MediaRangeImpl.constant("text", "*");

  static final Parser<MediaRange> parser = MEDIA_RANGE;

  factory MediaRange(final String type, final String subtype, {final Charset charset, Multimap<String,String, dynamic> parameters}) {
    checkArgument(TOKEN.parse(type).isNotEmpty);
    checkArgument(TOKEN.parse(subtype).isNotEmpty);
    Option<Charset> optionalCharset = new Option(charset);

    optionalCharset.map((final Charset charset) =>
        checkArgument(charset != Charset.ANY));

    parameters = firstNotNull(parameters, EMPTY_SET_MULTIMAP);
    parameters =
        EMPTY_SET_MULTIMAP.putAll(
            parameters.map((final Pair<String,String> kv) {
              checkArgument(TOKEN.parse(kv.fst).isNotEmpty);
              checkArgument(kv.fst.toLowerCase() != "q");
              checkArgument(kv.fst.toLowerCase() != "charset");
              checkArgument(QUOTABLE.matchesAllOf(kv.snd));
              return new Pair(kv.fst.toLowerCase(), kv.snd);
            }));

    return new MediaRangeImpl(
        type.toLowerCase(), subtype.toLowerCase(), optionalCharset, parameters);
  }

  Option<Charset> get charset;
  String get type;
  String get subtype;
  Multimap<String, String, dynamic> get parameters;

  MediaRange with_({final Charset charset, final Multimap<String, String, dynamic> parameters});
}


