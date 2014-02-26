part of restlib.core.http;

final Parser<Preference/*<Charset>*/> _CHARSET_PREFERENCE_PARSER = preferenceParser(Charset.parser);

final Parser<Preference/*<ContentEncoding>*/> _CONTENT_ENCODING_PREFERENCE_PARSER = preferenceParser(ContentEncoding.parser);

final Parser<Preference/*<Language>*/> _LANGUAGE_PREFERENCE_PARSER = preferenceParser(Language.parser);

final Parser<Preference/*<MediaRange>*/> _MEDIA_RANGE_PREFERENCE = preferenceParser(MediaRange.parser);

final Parser<Iterable<Preference/*<MediaRange>*/>> _ACCEPT = _MEDIA_RANGE_PREFERENCE.sepBy1(OWS_COMMA_OWS);

final Parser<Iterable<Preference/*<Charset>*/>> _ACCEPT_CHARSET = _CHARSET_PREFERENCE_PARSER.sepBy1(OWS_COMMA_OWS);

final Parser<Iterable<Preference/*<ContentEncoding>*/>> _ACCEPT_ENCODING = _CONTENT_ENCODING_PREFERENCE_PARSER.sepBy1(OWS_COMMA_OWS);

final Parser<Iterable<Preference/*<Language>*/>> _ACCEPT_LANGUAGE = _LANGUAGE_PREFERENCE_PARSER.sepBy1(OWS_COMMA_OWS);

final Parser<Iterable<RangeUnit>> _ACCEPT_RANGES = RangeUnit.parser.sepBy1(OWS_COMMA_OWS);

final Parser<Iterable<CacheDirective>> _CACHE_CONTROL = CacheDirective.parser.sepBy(OWS_COMMA_OWS);

final Parser<Iterable<ContentEncoding>> _CONTENT_ENCODING_HEADER = ContentEncoding.parser.sepBy(OWS_COMMA_OWS);

final Parser<Iterable<Language>> _CONTENT_LANGUAGE = Language.parser.sepBy(OWS_COMMA_OWS);

final Parser<CookieMultimap> _COOKIE =
  Cookie.parser.sepBy(SEMICOLON + SP).map((final Iterable<Cookie> cookies) =>
      CookieMultimap.EMPTY.putAll(cookies));

final Parser<Iterable<Expectation>> _EXPECT = Expectation.parser.sepBy(OWS_COMMA_OWS);

final Parser<Iterable<EntityTag>> _IF_MATCH = EntityTag.parser.sepBy(OWS_COMMA_OWS);

final Parser<Iterable<EntityTag>> _IF_NONE_MATCH = _IF_MATCH;

final Parser<Iterable<CacheDirective>> _PRAGMA = _CACHE_CONTROL;

final Parser<Iterable<Header>> _VARY = Header.parser.sepBy(OWS_COMMA_OWS);

final Parser<Iterable<Warning>> _WARNING = Warning.parser.sepBy(OWS_COMMA_OWS);