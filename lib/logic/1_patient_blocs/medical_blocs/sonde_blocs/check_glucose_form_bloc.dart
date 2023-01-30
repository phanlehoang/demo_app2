import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/data/models/medical/2_medical_check_glucose.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../data/models/models_export.dart';
import '../../../../data/models/sonde/7.2_sonde_procedure_online_cubit.dart';
import '../../../../data/models/sonde/sonde_lib.dart';

class CheckGlucoseForm extends FormBloc<String, String> {
  @override
  void emit(dynamic state) {
    try {
      super.emit(state);
    } catch (e) {
      if (e == StateError('Cannot emit new states after calling close')) {
        return;
      }
    }
  }
  final SondeProcedureOnlineCubit sondeProcedureOnlineCubit;
  final glucose = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );
  CheckGlucoseForm({
    required this.sondeProcedureOnlineCubit,
    
  }) {
    addFieldBlocs(
      fieldBlocs: [
        glucose,
      ],
    );
  }
  @override
  Future<void> onSubmitting() async {
    MedicalCheckGlucose medicalCheckGlucose = MedicalCheckGlucose(
      time: DateTime.now(),
      glucoseUI: num.parse(glucose.value),
    );

    try {
  
       await sondeProcedureOnlineCubit.addMedicalAction(medicalCheckGlucose);
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
    //noInsulinSondeCubit.emit(loadingNoInsulinSondeState());
    emitSuccess();
  }
}
