part of restlib.core.net;

final Parser<URI> URI_ = _iriParser(
    AUTHORITY,
    PATH,
    _QUERY,
    _FRAGMENT,
    _URI._builder);

final RuneMatcher _USER_INFO_SAFE_CHARS = _UNRESERVED | _SUB_DELIMS | COLON;                           
final Parser<String> _USER_INFO = new _PercentEncodedStringParser(_USER_INFO_SAFE_CHARS.matches);

final Parser<Either<DomainName, IPAddress>> _HOST = _REG_NAME ^ _IP_ADDRESS;

final RuneMatcher QUERY_SAFE_CHARS =  _PCHAR_SAFE_CHARS | anyOf("/?");
final Parser<String> _QUERY = new _PercentEncodedStringParser(QUERY_SAFE_CHARS.matches);

final RuneMatcher FRAGMENT_SAFE_CHARS = QUERY_SAFE_CHARS;
final Parser<String> _FRAGMENT = _QUERY;  

final RuneMatcher _PCHAR_SAFE_CHARS = _UNRESERVED | _SUB_DELIMS | anyOf(":@");
final Parser<String> _PCHAR = new _PercentEncodedStringParser(_PCHAR_SAFE_CHARS.matches);

final RuneMatcher _UNRESERVED = inRange('a','z') | inRange('A','Z') | inRange('0','9') | anyOf("-._~");
final RuneMatcher _RESERVERD = _GEN_DELIMS | _SUB_DELIMS;
final RuneMatcher _GEN_DELIMS= anyOf(":/?#[]@]");
final RuneMatcher _SUB_DELIMS = anyOf("!\$&'()*+,;=");







