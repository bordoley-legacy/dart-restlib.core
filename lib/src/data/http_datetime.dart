part of restlib.core.data;

// FIXME: Write a custom lexer to reduce memory
final Parser<String> _DAY_NAME =
  string("Mon") | string("Tue") | string("Wed") | string("Thu") | string("Fri") | string("Sat") | string("Sun");

final Parser<int> _2_DIGIT =
  (DIGIT + DIGIT).map((final Iterable e) => 
      e.elementAt(0) * 10 + e.elementAt(1));

final Parser<int> _MONTH =
  (string("Jan") |
  string("Feb") |
  string("Mar") |
  string("Apr") |
  string("May") |
  string("Jun") |
  string("Jul") |
  string("Aug") |
  string("Sep") |
  string("Oct") |
  string("Nov") |
  string("Dec")).map((final String month) {
    switch(month) {
      case "Jan":
        return 1;
      case "Feb":
        return 2;
      case "Mar":
        return 3;
      case "Apr":
        return 4;
      case "May":
        return 5;
      case "Jun":
        return 6;
      case "Jul":
        return 7;
      case "Aug":
        return 8;
      case "Sep":
        return 9;
      case "Oct":
        return 10;
      case "Nov":
        return 11;
      case "Dec":
        return 12;
    }   
  });

final Parser<int> _4_DIGIT =
  (DIGIT + DIGIT + DIGIT + DIGIT).map((final Iterable e) => 
      e.elementAt(0) * 1000 + e.elementAt(1) * 100 + e.elementAt(2) * 10 + e.elementAt(3));

final Parser<Iterable> _TIME_OF_DAY = 
  _2_DIGIT + COLON + _2_DIGIT + COLON + _2_DIGIT;

final Parser<Iterable> _DATE_1 =
  _2_DIGIT + SP + _MONTH + SP + _4_DIGIT;

final Parser<HttpDateTime> _IMF_FIX_DATE = 
  (_DAY_NAME + SP + _DATE_1 + SP + _TIME_OF_DAY + SP + string("GMT")).map((final Iterable e) {
    final int year = e.elementAt(2).elementAt(4);
    final int month = e.elementAt(2).elementAt(2);
    final int day = e.elementAt(2).elementAt(0);
    final int hour = e.elementAt(4).elementAt(0);
    final int minute = e.elementAt(4).elementAt(2);
    final int second = e.elementAt(4).elementAt(4);
    
    return new HttpDateTime._internal(new DateTime.utc(year, month, day, hour, minute, second));
  });

final Parser<HttpDateTime> HTTP_DATE_TIME = _IMF_FIX_DATE;

class HttpDateTime extends NoSuchMethodForwarder implements DateTime {
  factory HttpDateTime.now() {
    return new HttpDateTime._internal(new DateTime.now().toUtc());
  }
  
  HttpDateTime._internal(final DateTime delegate) : super(delegate);
  
  // FIXME
  String toString() => super.toString();
}