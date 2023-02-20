import '0_check_time_in_range.dart';
import '1_medical_range.dart';

class LantusRange extends MedicalRange {
  LantusRange()
      : super(ranges: [
          //4 khung gio
          //21h30 - 22h30
          Range(HourMinute(21, 30), HourMinute(22, 30)),
        ]);
  //waiting message

  @override
  String waitingMessage(DateTime t) {
    int indexNextRange = nextRange(t);
    int h = ranges[indexNextRange % ranges.length].start.hour;
    int m = ranges[indexNextRange % ranges.length].start.minute;
    String date = indexNextRange == ranges.length ? 'ngày mai' : '';
    return 'Bạn phải đợi đến $h: $m $date cho lần tiêm Lantus tiếp theo.';
  }
}

//mixing range
class MixingRange extends MedicalRange {
  MixingRange()
      : super(ranges: [
          //3 khung gio
          //5h30 - 6h30
          Range(HourMinute(5, 30), HourMinute(6, 30)),
          //11h30 - 12h30
          Range(HourMinute(11, 30), HourMinute(12, 30)),
          //17h30 - 18h30
          Range(HourMinute(17, 30), HourMinute(18, 30)),
        ]);
  //waiting message
  @override
  String waitingMessage(DateTime t) {
    int indexNextRange = nextRange(t);
    int h = ranges[indexNextRange % ranges.length].start.hour;
    int m = ranges[indexNextRange % ranges.length].start.minute;
    String date = indexNextRange == ranges.length ? ' ngày mai' : '';
    return 'Bạn phải đợi đến $h: $m$date cho lần truyền tiếp theo.';
  }
}
