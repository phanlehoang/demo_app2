

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/data/models/time_controller/2_sonde_range.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../enum/enums.dart';
import '../medical/4_regimen.dart';
import '../2_profile.dart';
import '../medical/6_procedure_state.dart';

class TPNProcedure {
  //1. attributes
  String name = 'TPNProcedure';
  DateTime beginTime;
  ProcedureState state;
  List<Regimen> regimens;
  TPNProcedure({
    required this.beginTime,
    required this.state,
    required this.regimens,
    this.name = 'TPNProcedure',
  });
  DateTime get lastTime {
    if (regimens.length == 0) {
      return beginTime;
    }
    return regimens.last.lastTime;
  }

  //toString 
  //get regimen status 
  RegimenStatus get fastStatus{
    //for down to up
    for (Regimen x in regimens.reversed) {
      if (x.regimenActrapidStatus(ActrapidRange()) == RegimenStatus.done) 
        return RegimenStatus.done;
    }
    if(regimens.length == 0){
      return RegimenStatus.checkingGlucose;
    }
    return regimens.last.regimenActrapidStatus(ActrapidRange());
  }
  //slowStatus 
  RegimenStatus get slowStatus{
    //tuy thuoc vao loai insulin tiem cham 
    //for down to up
    dynamic medicalRange;
    switch (state.slowInsulinType) {
      case InsulinType.NPH:
        medicalRange = NPHRange();
        break;
      case InsulinType.Glargine:
        medicalRange = GlargineRange();
        break;
      default:
       return RegimenStatus.checkingGlucose;
    }
    for (Regimen x in regimens.reversed) {
      if (x.regimenSlowStatus(medicalRange) == RegimenStatus.done) {
        return RegimenStatus.done;
      }
    }
    if(regimens.length == 0){
      return RegimenStatus.givingInsulin;
    }
    return regimens.last.regimenSlowStatus(medicalRange);
    }
  

  bool get isFull50{
    if(regimens.length == 0){
      return false;
    }
    return regimens.last.isFull50;
  }
  @override
  String toString() {
    return '''TPNProcedure: 
      {beginTime: $beginTime,\n state: $state,\n regimens: $regimens}
       ''';
  }
  //toMap 
  Map<String, dynamic> toMap() {
    return {
      'name': 'TPNProcedure',
      'beginTime': beginTime,
      'state': state.toMap(),
      'regimens': [for (Regimen x in regimens) x.toMap()],
    };
  }
  //toDataMap 
  Map<String, dynamic> toDataMap() {
     final map1 = {
      'name': 'TPNProcedure',
      'beginTime': beginTime,
     };
    return {...map1, ...state.toMap()};

  }

}