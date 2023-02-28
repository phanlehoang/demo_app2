import '../enum/enums.dart';
import '../medical/4_regimen.dart';
import '../medical/6_procedure_state.dart';
import '../medical/7_medical_procedure.dart';
import '1_TPN_procedure.dart';

class TPNProcedureInit {
  static TPNProcedure noInsulin(num weight) {
    return TPNProcedure(
        beginTime: DateTime.now(),
        state: ProcedureState(
          status: ProcedureStatus.noInsulin,
          slowInsulinType: InsulinType.Lantus,
          weight: weight,
        ),
        regimens: [
          Regimen(
            beginTime: DateTime.now(),
            name: 'No Insulin',
            medicalActions: [],
          )
        ]);
  }

  static TPNProcedure firstAsk(num weight) {
    return TPNProcedure(
      beginTime: DateTime.now(),
      state: ProcedureState(
          status: ProcedureStatus.firstAsk,
          slowInsulinType: InsulinType.Lantus,
          weight: weight),
      regimens: [],
    );
  }

  static TPNProcedure yesInsulin(num weight) {
    return TPNProcedure(
        beginTime: DateTime.now(),
        state: ProcedureState(
          status: ProcedureStatus.yesInsulin,
          slowInsulinType: InsulinType.Lantus,
          weight: weight,
        ),
        regimens: [
          Regimen(
            beginTime: DateTime.now(),
            name: 'yesInsulin',
            medicalActions: [],
          )
        ]);
  }
}
