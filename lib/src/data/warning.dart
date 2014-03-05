part of data;

abstract class Warning {
  static final Parser<Warning> parser = WARNING;

  Either<Authority, String> get warnAgent;
  int get warnCode;
  Option<DateTime> get warnDate;
  String get warnText;

  factory Warning.hostPort(final int warnCode, final Authority warnAgent, final String warnText, [final DateTime warnDate = null]) {
      checkArgument(warnCode > 0);
      checkArgument(warnCode <= 999);
      checkArgument(QUOTABLE.matchesAllOf(warnText));
      checkArgument(warnAgent.userInfo.isEmpty);

      return new WarningImpl(warnCode, new Either.leftValue(warnAgent), warnText, new Option(warnDate));
    }

  factory Warning.synomynAgent(final int warnCode, final String warnAgent, final String warnText, [final DateTime warnDate = null]) {
    checkArgument(warnCode > 0);
    checkArgument(warnCode <= 999);
    checkArgument(QUOTABLE.matchesAllOf(warnText));

    return new WarningImpl(warnCode, new Either.rightValue(warnAgent), warnText, new Option(warnDate));
  }
}