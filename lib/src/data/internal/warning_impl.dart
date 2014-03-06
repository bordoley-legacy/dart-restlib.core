part of data.internal;

final Parser<int> _WARN_CODE =
  (DIGIT + DIGIT + DIGIT)
    .map((final Tuple3<int, int, int> e) =>
        e.e0 * 100 + e.e1*10 + e.e2);

final Parser<Authority> _HOST_PORT = Authority.parser.map((final Authority authority) =>
    (authority.userInfo.isNotEmpty) ? null : authority);

final Parser<Either<Authority, String>> _WARN_AGENT = (_HOST_PORT ^ TOKEN);

final Parser<DateTime> _WARN_DATE =
  (DQUOTE + HTTP_DATE_TIME + DQUOTE)
    .map((final Tuple3<int, DateTime, int> e) =>
        e.e1);

final Parser<Option<DateTime>> _SP_WARN_DATE =
  (SP + _WARN_DATE).map((final Pair<int, DateTime> e) =>
      e.e1).optional();

final Parser<Warning> WARNING =
  (_WARN_CODE + SP + _WARN_AGENT + SP + QUOTED_STRING + _SP_WARN_DATE)
    .map((final Tuple6<int, int, Either<Authority, String>, int, String, Option<DateTime>> e) =>
        new WarningImpl(e.e0, e.e2, e.e4, e.e5));

class WarningImpl implements Warning {
  final Either<Authority, String> warnAgent;
  final int warnCode;
  final Option<DateTime> warnDate;
  final String warnText;

  const WarningImpl(this.warnCode, this.warnAgent, this.warnText, this.warnDate);

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