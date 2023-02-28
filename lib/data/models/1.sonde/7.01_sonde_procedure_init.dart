import '../enum/enums.dart';
import '../medical/4_regimen.dart';
import '../medical/6_procedure_state.dart';
import '../medical/7_medical_procedure.dart';
import '7_sonde_procedure.dart';

class SondeProcedureInit {
  static SondeProcedure noInsulin(num weight) {
    return SondeProcedure(
        beginTime: DateTime.now(),
        state:
            ProcedureState(status: ProcedureStatus.noInsulin, weight: weight),
        regimens: [
          Regimen(
            beginTime: DateTime.now(),
            name: 'No Insulin',
            medicalActions: [],
          )
        ]);
  }

  static SondeProcedure firstAsk(num weight) {
    return SondeProcedure(
      beginTime: DateTime.now(),
      state: ProcedureState(
        status: ProcedureStatus.firstAsk,
        weight: weight,
      ),
      regimens: [],
    );
  }

  static SondeProcedure yesInsulin(num weight) {
    return SondeProcedure(
        beginTime: DateTime.now(),
        state: ProcedureState(
          status: ProcedureStatus.yesInsulin,
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
