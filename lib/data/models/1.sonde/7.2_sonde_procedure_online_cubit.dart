import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../enum/enums.dart';
import '../medical/4_regimen.dart';
import '../2_profile.dart';
import '../medical/6_procedure_state.dart';
import '../medical/7.1_medical_procedure_cubit.dart';
import '7_sonde_procedure.dart';

class SondeProcedureOnlineCubit extends MedicalProcedureCubit {
  late StreamSubscription? regimensSubscription;
  late StreamSubscription? procedureStateSubscription;

  SondeProcedureOnlineCubit({
    required Profile profile,
    required String procedureId,
  }) : super(
          profile: profile,
          procedureId: procedureId,
        ) {
    regimensSubscription =
        procedureRef.collection('regimens').snapshots().listen((event) {
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
    procedureStateSubscription = procedureRef.snapshots().listen((event) {
      //event error
      if (event.data() == null) {
        emit(SondeProcedure(
          beginTime: state.beginTime,
          state: ProcedureState(
            status: ProcedureStatus.firstAsk,
          ),
          regimens: state.regimens,
        ));
        return;
      }
      ProcedureState sondeState =
          ProcedureState.fromMap(event.data() as Map<String, dynamic>);
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
    procedureStateSubscription?.cancel();
    return super.close();
  }
}

//init
SondeProcedure SondeProcedureOnlineInitial() {
  return SondeProcedure(
    status: 'Đang tải',
    beginTime: DateTime.now(),
    state: ProcedureState(
      status: ProcedureStatus.firstAsk,
    ),
    regimens: [],
  );
}
