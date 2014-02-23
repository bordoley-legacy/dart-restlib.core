part of restlib.core.http;

final Parser<Preference/*<Charset>*/> _CHARSET_PREFERENCE_PARSER = _preferenceParser(CHARSET);

final Parser<Preference/*<ContentEncoding>*/> _CONTENT_ENCODING_PREFERENCE_PARSER = _preferenceParser(CONTENT_ENCODING);

final Parser<Preference/*<Language>*/> _LANGUAGE_PREFERENCE_PARSER = _preferenceParser(LANGUAGE);

final Parser<Preference/*<MediaRange>*/> _MEDIA_RANGE_PREFERENCE = _preferenceParser(MEDIA_RANGE);

final Parser<Iterable<Preference/*<MediaRange>*/>> _ACCEPT = _MEDIA_RANGE_PREFERENCE.sepBy1(OWS_COMMA_OWS);

final Parser<Iterable<Preference/*<Charset>*/>> _ACCEPT_CHARSET = _CHARSET_PREFERENCE_PARSER.sepBy1(OWS_COMMA_OWS);

final Parser<Iterable<Preference/*<ContentEncoding>*/>> _ACCEPT_ENCODING = _CONTENT_ENCODING_PREFERENCE_PARSER.sepBy1(OWS_COMMA_OWS);

final Parser<Iterable<Preference/*<Language>*/>> _ACCEPT_LANGUAGE = _LANGUAGE_PREFERENCE_PARSER.sepBy1(OWS_COMMA_OWS);

final Parser<Iterable<RangeUnit>> _ACCEPT_RANGES = RANGE_UNIT.sepBy1(OWS_COMMA_OWS);

final Parser<Iterable<CacheDirective>> _CACHE_CONTROL = CACHE_DIRECTIVE.sepBy(OWS_COMMA_OWS);

final Parser<Iterable<ContentEncoding>> _CONTENT_ENCODING_HEADER = CONTENT_ENCODING.sepBy(OWS_COMMA_OWS);

final Parser<Iterable<Language>> _CONTENT_LANGUAGE = LANGUAGE.sepBy(OWS_COMMA_OWS);

final Parser<CookieMultimap> _COOKIE =
  COOKIE_PAIR.sepBy(SEMICOLON + SP).map((final Iterable<Cookie> cookies) =>
      CookieMultimap.EMPTY.putAll(cookies));

final Parser<Iterable<Expectation>> _EXPECT = EXPECTATION.sepBy(OWS_COMMA_OWS);

final Parser<Iterable<EntityTag>> _IF_MATCH = ETAG.sepBy(OWS_COMMA_OWS);

final Parser<Iterable<EntityTag>> _IF_NONE_MATCH = _IF_MATCH;

final Parser<Iterable<CacheDirective>> _PRAGMA = _CACHE_CONTROL;