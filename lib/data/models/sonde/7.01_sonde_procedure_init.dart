

import 'package:demo_app2/data/models/sonde/7_sonde_procedure.dart';

import '../enum/enums.dart';
import '../medical/4_regimen.dart';
import '6_sonde_state.dart';


class SondeProcedureInit{
  static SondeProcedure noInsulin(){
    return SondeProcedure(
      beginTime: DateTime.now(),
      state: SondeState(
        status: SondeStatus.noInsulin,
      ),
      regimens: [Regimen(
        beginTime: DateTime.now(),
         name: 'No Insulin',
          medicalActions: [],
        )]
    );
  }
  static SondeProcedure firstAsk(){
    return SondeProcedure(
            beginTime: DateTime.now(),

      state: SondeState(
        status: SondeStatus.firstAsk,
      ),
      regimens: [],
    );
  }
  static SondeProcedure yesInsulin(){
    return SondeProcedure(
      beginTime: DateTime.now(),
      state: SondeState(
        status: SondeStatus.yesInsulin,
      ),
      regimens: [Regimen(
        beginTime: DateTime.now(),
         name: 'yesInsulin',
          medicalActions: [],
        )]
    );
  }
}
