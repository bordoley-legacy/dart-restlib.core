part of restlib.core.http;

final Parser<Preference/*<Charset>*/> _CHARSET_PREFERENCE_PARSER = Preference.parser(CHARSET);

final Parser<Preference/*<ContentEncoding>*/> _CONTENT_ENCODING_PREFERENCE_PARSER = Preference.parser(CONTENT_ENCODING);

final Parser<Preference/*<Language>*/> _LANGUAGE_PREFERENCE_PARSER = Preference.parser(LANGUAGE);

final Parser<Preference/*<MediaRange>*/> _MEDIA_RANGE_PREFERENCE = Preference.parser(MEDIA_RANGE);
    
final Parser<Iterable<Preference/*<MediaRange>*/>> ACCEPT = _MEDIA_RANGE_PREFERENCE.sepBy1(OWS_COMMA_OWS);

final Parser<Iterable<Preference/*<Charset>*/>> ACCEPT_CHARSET = _CHARSET_PREFERENCE_PARSER.sepBy1(OWS_COMMA_OWS);

final Parser<Iterable<Preference/*<ContentEncoding>*/>> ACCEPT_ENCODING = _CONTENT_ENCODING_PREFERENCE_PARSER.sepBy1(OWS_COMMA_OWS);

final Parser<Iterable<Preference/*<Language>*/>> ACCEPT_LANGUAGE = _LANGUAGE_PREFERENCE_PARSER.sepBy1(OWS_COMMA_OWS);

final Parser<Iterable<RangeUnit>> ACCEPT_RANGES = RANGE_UNIT.sepBy1(OWS_COMMA_OWS);

final Parser<Iterable<CacheDirective>> CACHE_CONTROL = CACHE_DIRECTIVE.sepBy(OWS_COMMA_OWS);

final Parser<Iterable<ContentEncoding>> CONTENT_ENCODING_HEADER = CONTENT_ENCODING.sepBy(OWS_COMMA_OWS);

final Parser<Iterable<Language>> CONTENT_LANGUAGE = LANGUAGE.sepBy(OWS_COMMA_OWS);

final Parser<CookieMultimap> COOKIE = 
  (COOKIE_PAIR.sepBy(SEMICOLON + SP)).map((final Iterable<Cookie> cookies) =>
      CookieMultimap.EMPTY.putAll(cookies));

final Parser<Iterable<Expectation>> EXPECT = EXPECTATION.sepBy(OWS_COMMA_OWS);

final Parser<Iterable<EntityTag>> IF_MATCH = ETAG.sepBy(OWS_COMMA_OWS);

final Parser<Iterable<EntityTag>> IF_NONE_MATCH = IF_MATCH;

final Parser<Iterable<CacheDirective>> PRAGMA = CACHE_CONTROL;