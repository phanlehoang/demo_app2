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
  //1. attributes
}
