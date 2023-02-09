import 'package:demo_app2/data/models/medical/2_medical_check_glucose.dart';
import 'package:demo_app2/data/models/medical/4_regimen.dart';

import '../../../../data/models/medical/7_medical_procedure.dart';

class GlucoseExtract {
  static List<MedicalCheckGlucose> fromRegimen(Regimen regimen) {
    return regimen.medicalCheckGlucoses;
  }

  //from Medical Procedure
  static List<MedicalCheckGlucose> fromMedicalProcedure(
      MedicalProcedure medicalProcedure) {
    List<MedicalCheckGlucose> medicalCheckGlucoses = [];
    for (var regimen in medicalProcedure.regimens) {
      medicalCheckGlucoses.addAll(regimen.medicalCheckGlucoses);
    }
    return medicalCheckGlucoses;
  }
}
