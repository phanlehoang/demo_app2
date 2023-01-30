

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../enum/enums.dart';
import '../medical/4_regimen.dart';
import '../profile.dart';
import '6_sonde_state.dart';

class SondeProcedure {
  //1. attributes
  String name = 'SondeProcedure';
  DateTime beginTime;
  SondeState state;
  List<Regimen> regimens;
  SondeProcedure({
    required this.beginTime,
    required this.state,
    required this.regimens,
    this.name = 'SondeProcedure',
  });

  //toString 
  @override
  String toString() {
    return '''SondeProcedure: 
      {beginTime: $beginTime,\n state: $state,\n regimens: $regimens}
       ''';
  }
  //toMap 
  Map<String, dynamic> toMap() {
    return {
      'name': 'SondeProcedure',
      'beginTime': beginTime,
      'state': state.toMap(),
      'regimens': [for (Regimen x in regimens) x.toMap()],
    };
  }
  //toDataMap 
  Map<String, dynamic> toDataMap() {
     final map1 = {
      'name': 'SondeProcedure',
      'beginTime': beginTime,
     };
    return {...map1, ...state.toMap()};

  }
}
