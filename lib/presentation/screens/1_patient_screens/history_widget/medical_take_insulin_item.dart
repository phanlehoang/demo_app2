import 'package:demo_app2/presentation/screens/1_patient_screens/procedures_screens/nice_date_time.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/enum/1_enum_to_string.dart';
import '../../../../data/models/medical/3_medical_take_insulin.dart';
import '../../../widgets/nice_widgets/nice_export.dart';

class MedicalTakeInsulinItem extends StatelessWidget {
  final MedicalTakeInsulin medicalTakeInsulin;
  const MedicalTakeInsulinItem({
    Key? key,
    required this.medicalTakeInsulin,
  }) : super(key: key);
  //build
  @override
  Widget build(BuildContext context) {
    DateTime t = medicalTakeInsulin.time;
    String hm = NiceDateTime.hourMinute(t);
    String d = NiceDateTime.dayMonth(t);
    if (medicalTakeInsulin.insulinUI == 0) return Container();
    return SimpleContainer(
      child: ListTile(
          title: Text(
              'Tiêm Insulin ${EnumToString.enumToString(medicalTakeInsulin.insulinType)}'),
          subtitle: Text(medicalTakeInsulin.insulinUI.toString() + ' UI'),
          trailing: Column(
            children: [
              Text(d),
              Text(hm),
            ],
          )),
    );
  }
}
