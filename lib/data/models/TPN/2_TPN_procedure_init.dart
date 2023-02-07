import '../enum/enums.dart';
import '../medical/4_regimen.dart';
import '../medical/6_procedure_state.dart';
import '../medical/7_medical_procedure.dart';
import '1_TPN_procedure.dart';

class TPNProcedureInit {
  static TPNProcedure noInsulin() {
    return TPNProcedure(
        beginTime: DateTime.now(),
        state: ProcedureState(
          status: ProcedureStatus.noInsulin,
          slowInsulinType: InsulinType.Lantus,
        ),
        regimens: [
          Regimen(
            beginTime: DateTime.now(),
            name: 'No Insulin',
            medicalActions: [],
          )
        ]);
  }

  static TPNProcedure firstAsk() {
    return TPNProcedure(
      beginTime: DateTime.now(),
      state: ProcedureState(
          status: ProcedureStatus.firstAsk,
          slowInsulinType: InsulinType.Lantus),
      regimens: [],
    );
  }

  static TPNProcedure yesInsulin() {
    return TPNProcedure(
        beginTime: DateTime.now(),
        state: ProcedureState(
          status: ProcedureStatus.yesInsulin,
          slowInsulinType: InsulinType.Lantus,
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
