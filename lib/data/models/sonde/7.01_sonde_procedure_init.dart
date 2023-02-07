import '../enum/enums.dart';
import '../medical/4_regimen.dart';
import '../medical/6_procedure_state.dart';
import '../medical/7_medical_procedure.dart';
import '7_sonde_procedure.dart';

class SondeProcedureInit {
  static SondeProcedure noInsulin() {
    return SondeProcedure(
        beginTime: DateTime.now(),
        state: ProcedureState(
          status: ProcedureStatus.noInsulin,
        ),
        regimens: [
          Regimen(
            beginTime: DateTime.now(),
            name: 'No Insulin',
            medicalActions: [],
          )
        ]);
  }

  static SondeProcedure firstAsk() {
    return SondeProcedure(
      beginTime: DateTime.now(),
      state: ProcedureState(
        status: ProcedureStatus.firstAsk,
      ),
      regimens: [],
    );
  }

  static SondeProcedure yesInsulin() {
    return SondeProcedure(
        beginTime: DateTime.now(),
        state: ProcedureState(
          status: ProcedureStatus.yesInsulin,
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
