part of restlib.core.data;

final Parser<int> _WARN_CODE =
  (DIGIT + DIGIT + DIGIT)
    .map((final Iterable e) =>
      e.elementAt(0) * 100 + e.elementAt(1)*10 + e.elementAt(2));

final Parser<Authority> _HOST_PORT = AUTHORITY.map((final Authority authority) =>
    (authority.userInfo.isNotEmpty) ? null : authority);

final Parser<Either<Authority, String>> _WARN_AGENT = (_HOST_PORT ^ TOKEN);

final Parser<DateTime> _WARN_DATE =
  (DQUOTE + HTTP_DATE_TIME + DQUOTE)
    .map((final Iterable e) =>
        e.elementAt(1));

final Parser<Option<DateTime>> _SP_WARN_DATE =
  (SP + _WARN_DATE).map((final Iterable e) =>
      e.elementAt(1)).optional();

final Parser<Warning> WARNING =
  (_WARN_CODE + SP + _WARN_AGENT + SP + QUOTED_STRING + _SP_WARN_DATE)
    .map((final Iterable e) => 
        new Warning._internal(e.elementAt(0), e.elementAt(2), e.elementAt(4), e.elementAt(5)));
  
class Warning {
  final Either<Authority, String> warnAgent;
  final int warnCode;
  final Option<DateTime> warnDate;
  final String warnText;
  
  factory Warning.hostPort(final int warnCode, final Authority warnAgent, final String warnText, [final DateTime warnDate = null]) {
    checkArgument(warnCode > 0);
    checkArgument(warnCode <= 999);
    checkArgument(QUOTABLE.matchesAllOf(warnText));
    checkArgument(warnAgent.userInfo.isEmpty);
    
    return new Warning._internal(warnCode, new Either.leftValue(warnAgent), warnText, new Option(warnDate));
  }
  
  factory Warning.synomynAgent(final int warnCode, final String warnAgent, final String warnText, [final DateTime warnDate = null]) {
    checkArgument(warnCode > 0);
    checkArgument(warnCode <= 999);
    checkArgument(QUOTABLE.matchesAllOf(warnText));
    
    return new Warning._internal(warnCode, new Either.rightValue(warnAgent), warnText, new Option(warnDate));
  }
  
  const Warning._internal(this.warnCode, this.warnAgent, this.warnText, this.warnDate);
  
  int get hashCode => 
      computeHashCode([warnAgent, warnCode, warnDate, warnText]);
  
  bool operator==(final other) {
    if (identical(this, other)) {
      return true;
    } else if (other is Warning) {
      return this.warnCode == other.warnCode &&
          this.warnAgent == other.warnAgent &&
          this.warnText == other.warnText &&
          this.warnDate == other.warnDate;
    } else {
      return true;
    }
  }
  
  String toString() =>
      "$warnCode $warnAgent ${encodeQuotedString(warnText)}${warnDate.map(toHttpDate).orElse("")}";
}