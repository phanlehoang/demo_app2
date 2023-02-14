import '0_check_time_in_range.dart';

abstract class MedicalRange {
  final List<Range> ranges;
  MedicalRange({required this.ranges});
  int? rangeContain(DateTime t) {
    for (int i = 0; i < ranges.length; i++) {
      if (inRange(t, ranges[i])) {
        return i;
      }
    }
    return null;
  }

  int? rangeContainToday(DateTime t) {
    int? index = rangeContain(t);
    if (index == null) return null;
    var ans = inRangeToday(t, ranges[index]);
    return ans ? index : null;
  }

  int nextRange(DateTime t) {
    HourMinute hm = HourMinute(t.hour, t.minute);
    for (int i = 0; i < ranges.length; i++) {
      if (hm < ranges[i].start) {
        return i;
      }
    }
    return ranges.length;
  }

  String waitingMessage(DateTime t) {
    int indexNextRange = nextRange(t);
    int h = ranges[indexNextRange % ranges.length].start.hour;
    int m = ranges[indexNextRange % ranges.length].start.minute;
    String date = indexNextRange == ranges.length ? ' ngày mai' : '';
    return 'Bạn phải đợi đến $h: $m$date cho lần điều trị tiếp theo.';
  }

  bool isHot(DateTime t) {
    return rangeContainToday(t) != null &&
        rangeContain(t) == rangeContain(DateTime.now());
  }
}
