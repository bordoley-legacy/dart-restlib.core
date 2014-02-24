part of restlib.core.http.internal;

// FIXME: String copy is unfortunate
final Parser<String> BASE64 =
  ((ALPHA_NUMERIC | anyOf("-._~+/")).many1() + EQUALS.many())
    .map((final Iterable<IterableString> e) =>
        e.elementAt(0).toString() + e.elementAt(1).toString());

final Parser<IterableString> BWS = OWS;

final RuneMatcher CTEXT =
  WSP |
  inRange('\u0021', '\'') |
  inRange('\u002A', '\u005B') |
  inRange('\u005D', '\u007E') |
  OBS_TEXT;

final RuneMatcher ETAGC =
  isChar("\u0021") |
  inRange("\u0023", "\u007E") |
  OBS_TEXT;

final RuneMatcher FIELD_VALUE =
  WSP | VCHAR | OBS_TEXT;

final RuneMatcher HOST_PORT =
  TCHAR | isChar(":");

final RuneMatcher OBS_TEXT = inRange('\u0080','\u00FF');

final RuneMatcher QD_TEXT =
  WSP |
  isChar("\u0021") |
  inRange("\u0023", "\u005B") |
  inRange("\u005D", "\u007E") |
  OBS_TEXT;

final RuneMatcher QUOTED_CPAIR_CHAR =
  WSP | VCHAR | OBS_TEXT;

final RuneMatcher QUOTED_PAIR_CHAR =
  WSP | VCHAR | OBS_TEXT;

final RuneMatcher QUOTABLE = QD_TEXT | QUOTED_PAIR_CHAR;

const Parser<String> QUOTED_STRING = const _QuotedStringParser();

final Parser<String> OPTIONAL_WORD = WORD.orElse("");

final Parser<IterableString> OWS = WSP.many();

final Parser<String> OWS_SEMICOLON_OWS = (OWS + SEMICOLON + OWS).map((val) => ";");

final Parser<String> OWS_COMMA_OWS = (OWS + COMMA + OWS).map((val) => ",");

final RuneMatcher REASON_PHRASE =
  WSP | VCHAR | OBS_TEXT;

final Parser<IterableString> RWS = WSP.many1();

final RuneMatcher TCHAR =
  ALPHA_NUMERIC | anyOf("!#\$%&'*+-.^_`|~");

final Parser<String> TOKEN = TCHAR.many1().map(objectToString);

final Parser<String> WORD = TOKEN | QUOTED_STRING;