import 'package:demo_app2/data/models/enum/enums.dart';

import '../medical/6_procedure_state.dart';

class SondeSlowInsulinSolve {
  final InsulinType insulinType;
  SondeSlowInsulinSolve({required this.insulinType});
}

class NPHInsulinSolve extends SondeSlowInsulinSolve {
  NPHInsulinSolve() : super(insulinType: InsulinType.NPH);
  num insulinAmount({required ProcedureState sondeState}) {
    num init = sondeState.weight * 0.1;
    if (sondeState.status == ProcedureStatus.highInsulin) {
      return (init * 1.1).round();
    }
    return init.round();
  }

  String guide({required ProcedureState sondeState}) {
    return 'Tiem NPH ${insulinAmount(sondeState: sondeState)} UI';
  }
}

class GlargineInsulinSolve extends SondeSlowInsulinSolve {
  GlargineInsulinSolve() : super(insulinType: InsulinType.Glargine);
  num insulinAmount({required ProcedureState sondeState}) {
    num init = sondeState.weight * 0.2;
    if (sondeState.status == ProcedureStatus.highInsulin) {
      return (init * 1.1).round();
    }
    return init.round();
  }

  String guide({required ProcedureState sondeState}) {
    return 'Tiem Glargine ${insulinAmount(sondeState: sondeState)} UI';
  }
}

//Lantus Insulin Solve
class LantusInsulinSolve extends SondeSlowInsulinSolve {
  LantusInsulinSolve() : super(insulinType: InsulinType.Lantus);
  num insulinAmount({required ProcedureState sondeState}) {
    num init = sondeState.weight * 0.2;
    if (sondeState.status == ProcedureStatus.highInsulin) {
      return (init * 1.1).round();
    }
    return init.round();
  }

  String guide({required ProcedureState sondeState}) {
    return 'Tiem Lantus ${insulinAmount(sondeState: sondeState)} UI';
  }
}
