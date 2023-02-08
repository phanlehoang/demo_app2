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
    int h = ranges[indexNextRange].start.hour;
    int m = ranges[indexNextRange].start.minute;
    return 'Bạn phải đợi đến $h: $m ngày mai cho lần tiêm Lantus tiếp theo.';
  }
}
