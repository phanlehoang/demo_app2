
 import '0_check_time_in_range.dart';
import '1_medical_range.dart';



class ActrapidRange extends MedicalRange{
  ActrapidRange():super(ranges: [
    //4 khung gio 
    Range(HourMinute(5, 30), HourMinute(6, 30)),
    Range(HourMinute(11, 30), HourMinute(12, 30)),
    Range(HourMinute(17, 30), HourMinute(18, 30)),
    Range(HourMinute(21, 30), HourMinute(22, 30)),
  ]);
  
}

class GlargineRange extends MedicalRange{

  GlargineRange():super(ranges: [
    Range(HourMinute(21, 30), HourMinute(22, 30)),
  ]);
  //message
  @override
   String waitingMessage(DateTime t) {
    int indexNextRange = nextRange(t);
    int h = ranges[indexNextRange].start.hour;
    int m = ranges[indexNextRange].start.minute;
    return 'Bạn phải đợi đến $h: $m cho lần tiêm Glargine tiếp theo.';
  }
}
class NPHRange extends MedicalRange{
  NPHRange():super(ranges: [
    Range(HourMinute(5, 30), HourMinute(6, 30)),
    Range(HourMinute(17, 30), HourMinute(18, 30)),
  ]);
  //message 
  @override
  String waitingMessage(DateTime t) {
    int indexNextRange = nextRange(t);
    int h = ranges[indexNextRange].start.hour;
    int m = ranges[indexNextRange].start.minute;
    return 'Bạn phải đợi đến $h: $m cho lần tiêm NPH tiếp theo.';
  }
}
 

