// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:demo_app2/data/models/time_controller/2_sonde_range.dart';

import '../2_profile.dart';
import '../enum/enums.dart';
import '../medical/4_regimen.dart';
import '../medical/6_procedure_state.dart';
import '../medical/7_medical_procedure.dart';
import '../time_controller/3_TPN_range.dart';

class TPNProcedure extends MedicalProcedure {
  String status;
  TPNProcedure(
      {this.status = 'ok',
      required super.beginTime,
      required super.state,
      required super.regimens})
      : super(name: 'TPNProcedure');

  @override
  String toString() {
    return '''TPNProcedure: 
      {beginTime: $beginTime,\n state: $state,\n regimens: $regimens}
       ''';
  }

  static Widget get officialName {
    return Text('Phác đồ cho bệnh nhân ĐTĐ nuôi dưỡng bằng đường tĩnh mạch',
        //bôi đậm
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center);
  }
}
