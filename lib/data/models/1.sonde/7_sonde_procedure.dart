import 'package:flutter/material.dart';

import '../medical/7_medical_procedure.dart';

class SondeProcedure extends MedicalProcedure {
  String status;
  SondeProcedure(
      {this.status = 'ok',
      required super.beginTime,
      required super.state,
      required super.regimens})
      : super(
          name: 'SondeProcedure',
        );
  static Widget get officialName {
    return Text('Phác đồ cho bệnh nhân ĐTĐ nuôi dưỡng qua sonde',
        //bôi đậm
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center);
  }
  //1. attributes
}
