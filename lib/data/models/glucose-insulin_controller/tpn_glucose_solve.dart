import '../medical/4_regimen.dart';
import '../medical/6_procedure_state.dart';
import 'glucose_solve.dart';

class TPNGlucoseSolve {
  static GlucoseEvaluation eval(num glucose) {
    if (glucose < 3.9) {
      return GlucoseEvaluation.low;
    }
    if (glucose <= 8.3) {
      return GlucoseEvaluation.normal;
    }
    if (glucose <= 11.1) {
      return GlucoseEvaluation.high;
    }
    return GlucoseEvaluation.superHigh;
  }

  static num insulinGuide({
    required Regimen regimen,
    required ProcedureState procedureState,
  }) {
    final num glucose = regimen.lastGluAmount;
    final GlucoseEvaluation evaluation = eval(glucose);
    switch (evaluation) {
      case GlucoseEvaluation.high:
        return 2;
      case GlucoseEvaluation.superHigh:
        return 4;
      default:
        return 0;
    }
  }

  static String insulinGuideString({
    required Regimen regimen,
    required ProcedureState procedureState,
  }) {
    num insulin = insulinGuide(
      regimen: regimen,
      procedureState: procedureState,
    );
    if (insulin == 0) return 'Không cần tiêm thêm insulin.';
    return 'Tiêm ${insulin} UI Insulin Actrapid';
  }
}
