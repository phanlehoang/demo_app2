import 'package:demo_app2/data/models/TPN/1_TPN_procedure.dart';
import 'package:demo_app2/data/models/enum/enums.dart';
import 'package:demo_app2/data/models/time_controller/3_TPN_range.dart';

import '../../../../../data/models/medical/2.1_medical_mixing.dart';
import '../../../../../data/models/medical/4_regimen.dart';

class TPNMixingStatusLogic {
  final procedure;

  TPNMixingStatusLogic({required this.procedure});

  RegimenStatus regimenStatus(Regimen regimen) {
    //b1: tìm last time mixing
    DateTime t = DateTime(1999);
    for (dynamic medicalAction in regimen.medicalActions) {
      if (medicalAction is MedicalMixing) {
        if (medicalAction.time.isAfter(t)) t = medicalAction.time;
      }
    }
    if (MixingRange().isHot(t)) {
      return RegimenStatus.done;
    } else
      return RegimenStatus.guideMixing;
  }

  //lần cuối mixing
  DateTime get lastMix {
    DateTime t = DateTime(1999);
    for (Regimen regimen in procedure.regimens) {
      for (dynamic medicalAction in regimen.medicalActions) {
        if (medicalAction is MedicalMixing) {
          if (medicalAction.time.isAfter(t)) t = medicalAction.time;
        }
      }
    }
    return t;
  }

  bool get stillMixing {
    DateTime last = lastMix;
    DateTime lastPlus5h = last.add(Duration(hours: 5));
    DateTime now = DateTime.now();
    if (now.isAfter(lastPlus5h))
      return false;
    else
      return true;
  }

  RegimenStatus get status {
    if (MixingRange().rangeContainToday(DateTime.now()) == null) {
      return RegimenStatus.done;
    }
    if (procedure.regimens.length == 0) return RegimenStatus.guideMixing;
    for (Regimen regimen in procedure.regimens) {
      if (regimenStatus(regimen) == RegimenStatus.done)
        return RegimenStatus.done;
    }
    return RegimenStatus.guideMixing;
  }
}
