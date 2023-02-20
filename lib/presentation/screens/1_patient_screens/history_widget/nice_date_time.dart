class NiceDateTime {
  static String dayMonth(DateTime t) {
    num d = t.day;
    num m = t.month;

    return '$d Th $m';
  }

  static String hourMinute(DateTime t) {
    num h = t.hour;
    num m = t.minute;

    return '$h:$m';
  }

  static hourMinuteDayMonth(DateTime t) {
    num h = t.hour;
    num m = t.minute;
    num d = t.day;
    num month = t.month;

    return '$h:$m\n $d/$month   ';
  }

  static String dayMonthYear(DateTime t) {
    num d = t.day;
    num m = t.month;
    num y = t.year;

    return '$d/$m/$y';
  }

  static String yearMonthDayHourMinuteSecond(DateTime t) {
    num d = t.day;
    num m = t.month;
    num y = t.year;
    num h = t.hour;
    num min = t.minute;
    num s = t.second;

    return '$y-$m-$d $h:$min:$s';
  }
}
