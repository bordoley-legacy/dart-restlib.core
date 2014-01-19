part of restlib.core.http_syntax;

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

final Parser<DateTime> _IMF_FIX_DATE = 
  (_DAY_NAME + COMMA + SP + _DATE_1 + SP + _TIME_OF_DAY + SP + string("GMT")).map((final Iterable e) {
    final int year = e.elementAt(3).elementAt(4);
    final int month = e.elementAt(3).elementAt(2);
    final int day = e.elementAt(3).elementAt(0);
    final int hour = e.elementAt(5).elementAt(0);
    final int minute = e.elementAt(5).elementAt(2);
    final int second = e.elementAt(5).elementAt(4);
    
    return new DateTime.utc(year, month, day, hour, minute, second);
  });

final Parser<DateTime> HTTP_DATE_TIME = _IMF_FIX_DATE;


String _twoDigit(final int number) {
  checkArgument(number >=0 && number < 100);
  
  if (number > 9) {
    return number.toString();
  } else {
    return "0$number";
  }
}

String _day(final DateTime date) {
  switch(date.weekday) {
    case DateTime.MONDAY:
      return "Mon";
    case DateTime.TUESDAY:
      return "Tue";
    case DateTime.WEDNESDAY:
      return "Wed";
    case DateTime.THURSDAY:
      return "Thu";
    case DateTime.FRIDAY:
      return "Fri";  
    case DateTime.SATURDAY:
      return "Sat";    
    case DateTime.SUNDAY:
      return "Sun";  
    default:
      throw new ArgumentError("Not a weekday");
   }
}

String _month(final DateTime date) {
  switch(date.month) {
    case DateTime.JANUARY:
      return "Jan";
    case DateTime.FEBRUARY:
      return "Feb";
    case DateTime.MARCH:
      return "Mar";
    case DateTime.APRIL:
      return "Apr";
    case DateTime.MAY:
      return "May";
    case DateTime.JUNE:
      return "Jun";
    case DateTime.JULY:
      return "Jul";
    case DateTime.AUGUST:
      return "Aug";
    case DateTime.SEPTEMBER:
      return "Sep";
    case DateTime.OCTOBER:
      return "Oct";
    case DateTime.NOVEMBER:
      return "Nov";
    case DateTime.DECEMBER:
      return "Dec";
    default:
      throw new ArgumentError("Not a month");
  }
}

String toHttpDate(final DateTime dateTime) {
  final DateTime utc = dateTime.toUtc();
  return "${_day(utc)}, ${_twoDigit(utc.day)} ${_month(utc)} ${utc.year} ${_twoDigit(utc.hour)}:${_twoDigit(utc.minute)}:${_twoDigit(utc.second)} GMT";
}