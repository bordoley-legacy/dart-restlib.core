part of net;

final Parser<IRI> _IRI_ = _iriParser(
    _I_AUTHORITY,
    _I_PATH,
    _I_QUERY,
    _I_FRAGMENT,
    _IRI._builder);

final RuneMatcher _I_USER_INFO_SAFE_CHARS = _I_UNRESERVED | _SUB_DELIMS | COLON;
final Parser<String> _I_USER_INFO = new _PercentEncodedStringParser(_I_USER_INFO_SAFE_CHARS.matches);

final Parser<Either<InternationalDomainName, IPAddress>> _I_HOST = _I_REG_NAME ^ _IP_ADDRESS;

final RuneMatcher _I_PCHAR_SAFE_CHARS = _PCHAR_SAFE_CHARS | _I_UNRESERVED;
final Parser<String> _I_PCHAR = new _PercentEncodedStringParser(_I_PCHAR_SAFE_CHARS.matches);

final RuneMatcher _I_QUERY_SAFE_CHARS =  _I_PCHAR_SAFE_CHARS | _I_PRIVATE | anyOf("/?");
final Parser<String> _I_QUERY = new _PercentEncodedStringParser(_I_QUERY_SAFE_CHARS.matches);

final RuneMatcher _I_FRAGMENT_SAFE_CHARS = _I_PCHAR_SAFE_CHARS | anyOf("/?");
final Parser<String> _I_FRAGMENT = new _PercentEncodedStringParser(_I_FRAGMENT_SAFE_CHARS.matches);

final RuneMatcher _USCHAR =
  inRange("\u{00A0}", "\u{D7FF}")   | inRange("\u{F900}","\u{FDCF}")    | inRange("\u{FDF0}","\u{FFEF}")    |
  inRange("\u{10000}", "\u{1FFFD}") | inRange("\u{20000}", "\u{2FFFD}") | inRange("\u{30000}", "\u{3FFFD}") |
  inRange("\u{40000}", "\u{4FFFD}") | inRange("\u{50000}", "\u{5FFFD}") | inRange("\u{60000}", "\u{6FFFD}") |
  inRange("\u{70000}", "\u{7FFFD}") | inRange("\u{80000}", "\u{8FFFD}") | inRange("\u{90000}", "\u{9FFFD}") |
  inRange("\u{A0000}", "\u{AFFFD}") | inRange("\u{B0000}", "\u{BFFFD}") | inRange("\u{C0000}", "\u{CFFFD}") |
  inRange("\u{D0000}", "\u{DFFFD}") | inRange("\u{E1000}", "\u{EFFFD}");

final RuneMatcher _I_PRIVATE = 
  inRange("\uE000", "\uF8FF") | inRange("\uF0000", "\uFFFFD")  | inRange("\u100000", "\u10FFFD");

final RuneMatcher _I_UNRESERVED = _UNRESERVED | _USCHAR;
