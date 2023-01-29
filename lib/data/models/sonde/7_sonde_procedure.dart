

import 'dart:async';

import 'package:demo_app2/data/models/sonde/4_regimen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../enum/enums.dart';
import '../profile.dart';
import '5_regimen_state.dart';
import '6_sonde_state.dart';

class SondeProcedure {
  SondeState state;
  List<Regimen> regimens;
  SondeProcedure({
    required this.state,
    required this.regimens,
  });
  //toString 
  @override
  String toString() {
    return 'SondeProcedure: {state: $state,\n regimens: $regimens}';
  }
}
class SondeProcedureOnlineCubit extends Cubit<SondeProcedure> {
  late StreamSubscription _regimenStateSubscription;
  late StreamSubscription _sondeStateSubscription;
  late StreamSubscription _historyOldSubscription;

  SondeProcedureOnlineCubit({required Profile profile }) : super(SondeProcedure(
    state: SondeState(
      status: SondeStatus.firstAsk,
    ),
    regimens: [],
  )){
  
  }
}
