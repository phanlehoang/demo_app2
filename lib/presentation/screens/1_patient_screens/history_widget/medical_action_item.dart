import 'package:demo_app2/data/models/medical/2.1_medical_mixing.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/medical/2_medical_check_glucose.dart';
import '../../../../data/models/medical/3_medical_take_insulin.dart';
import '../../../widgets/nice_widgets/nice_export.dart';
import 'medical_check_glucose_item.dart';
import 'medical_mixing_item.dart';
import 'medical_take_insulin_item.dart';

class MedicalActionItem extends StatelessWidget {
  final medicalAction;
  const MedicalActionItem({
    Key? key,
    required this.medicalAction,
  }) : super(key: key);
  //build
  @override
  Widget build(BuildContext context) {
    switch (medicalAction.runtimeType) {
      case MedicalCheckGlucose:
        return MedicalCheckGlucoseItem(medicalCheckGlucose: medicalAction);
      case MedicalTakeInsulin:
        return MedicalTakeInsulinItem(medicalTakeInsulin: medicalAction);
      case MedicalMixing:
        return MedicalMixingItem(medicalMixing: medicalAction);
      default:
        return Text('chua lam');
    }
  }
}
