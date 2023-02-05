

import '0_check_time_in_range.dart';
import '1_medical_range.dart';

class LantusRange extends MedicalRange{
  LantusRange():super(ranges: [
    //4 khung gio 
    //21h30 - 22h30
    Range(HourMinute(21, 30), HourMinute(22, 30)),
  ]);
}


