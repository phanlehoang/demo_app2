import 'package:demo_app2/presentation/screens/1_patient_screens/history_widget/nice_date_time.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/medical/4_regimen.dart';
import 'medical_action_item.dart';

class RegimenItem extends StatelessWidget {
  final Regimen regimen;
  const RegimenItem({
    Key? key,
    required this.regimen,
  }) : super(key: key);
  //build
  @override
  Widget build(BuildContext context) {
    String first = NiceDateTime.dayMonthYear(regimen.beginTime);
    String last = NiceDateTime.dayMonthYear(regimen.lastTime);
    return Column(
      children: [
        Text('Regimen: ${regimen.name}'),
        Text(' $first - $last'),
        for (var medicalAction in regimen.medicalActions.reversed)
          MedicalActionItem(medicalAction: medicalAction),
      ],
    );
  }
}
