


import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/data/models/sonde/7.01_sonde_procedure_init.dart';
import 'package:demo_app2/data/models/sonde/7_sonde_procedure.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../data/data_provider/patient_provider.dart';
import '../../data/models/profile.dart';
import '../../presentation/widgets/vietnamese/vietnamese_field_bloc_validators.dart';

class CreateProcedureFormBloc extends FormBloc<String,String>{
  final Profile profile;
  final method = SelectFieldBloc(
    items: ['TPN', 'Sonde'],
    validators: [VietnameseFieldBlocValidators.required],
  );
  @override
  CreateProcedureFormBloc({required this.profile}){
    addFieldBlocs(step: 0, fieldBlocs: [
      method,
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async{
    try 
    {
      await _createProcedure();
      emitSuccess();
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
    
}

  Future<void> _createProcedure() async{
    if (method.value == 'Sonde') {
      //sonde init procedure 
      final SondeProcedure sondeProcedure = SondeProcedureInit.firstAsk();
      var addProcedure = await PatientRef.getPatientRef(profile)
      .collection('procedures').doc(sondeProcedure.beginTime.toString())
      .set(sondeProcedure.toDataMap());
  }
  }
}

