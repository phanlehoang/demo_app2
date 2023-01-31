import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../enum/enums.dart';
import '../medical/4_regimen.dart';
import '../2_profile.dart';
import '6_sonde_state.dart';
import '7.1_sonde_procedure_cubit.dart';
import '7_sonde_procedure.dart';

class SondeProcedureOnlineCubit extends SondeProcedureCubit{
  late StreamSubscription ?regimensSubscription;
  late StreamSubscription ?sondeStateSubscription;

  SondeProcedureOnlineCubit({ 
      required Profile profile,
      required String procedureId,
    })  :  super(
          profile: profile,
          procedureId: procedureId,
          ){
    regimensSubscription = sondeRef().collection('regimens').snapshots().listen((event) {
      List<Regimen> regimens = [];
      List<dynamic> list = event.docs.map((e) => e.data()).toList();
      for (dynamic x in list) {
        regimens.add(Regimen.fromMap(x));
      }
      emit(SondeProcedure(
        beginTime: state.beginTime,
        state: state.state,
        regimens: regimens,
      ));
    });
    sondeStateSubscription = sondeRef().snapshots().listen((event) {
      //event error 
      if (event.data() == null) {
        emit(SondeProcedure(
          beginTime: state.beginTime,
          state: SondeState(
            status: SondeStatus.firstAsk,
          ),
          regimens: state.regimens,
        ));
        return;
      }
      SondeState sondeState = SondeState.
      fromMap(event.data() as Map<String, dynamic>);
      emit(SondeProcedure(
        beginTime: state.beginTime,
        state: sondeState,
        regimens: state.regimens,

      ));
    });
     
  }
  //emit
  @override   
  Future<void> close() {
    regimensSubscription?.cancel();
    sondeStateSubscription?.cancel();
    return super.close();
  }
}

//init
SondeProcedure SondeProcedureOnlineInitial() {
  return SondeProcedure(
    name: 'Đang tải',
    beginTime: DateTime.now(),
    state: SondeState(
      status: SondeStatus.firstAsk,
    ),
    regimens: [],
  );
}
