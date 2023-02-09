import 'package:demo_app2/data/models/medical/2_medical_check_glucose.dart';
import 'package:demo_app2/presentation/screens/1_patient_screens/history_widget/nice_date_time.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/enum/1_enum_to_string.dart';
import '../../../../data/models/medical/3_medical_take_insulin.dart';
import '../../../widgets/nice_widgets/nice_export.dart';

class MedicalCheckGlucoseItem extends StatelessWidget {
  final MedicalCheckGlucose medicalCheckGlucose;
  const MedicalCheckGlucoseItem({
    Key? key,
    required this.medicalCheckGlucose,
  }) : super(key: key);
  //build
  @override
  Widget build(BuildContext context) {
    DateTime t = medicalCheckGlucose.time;
    String hm = NiceDateTime.hourMinute(t);
    String d = NiceDateTime.dayMonth(t);
    return SimpleContainer(
      child: ListTile(
          title: Text('Glucose '),
          subtitle: Text(medicalCheckGlucose.glucoseUI.toString() + ' UI'),
          trailing: Column(
            children: [
              Text(d),
              Text(hm),
            ],
          )),
    );
  }
}
