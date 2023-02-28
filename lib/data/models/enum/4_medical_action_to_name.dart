import '../medical/2_medical_check_glucose.dart';
import '../medical/3_medical_take_insulin.dart';
import '../1.sonde/sonde_lib.dart';

class MedicalActionToName {
  static String name(dynamic action) {
    switch (action.runtimeType) {
      case MedicalCheckGlucose:
        return 'Kiểm tra glucose';
      case MedicalTakeInsulin:
        return 'Tiêm insulin';

      default:
        return 'Unknown';
    }
  }
}
