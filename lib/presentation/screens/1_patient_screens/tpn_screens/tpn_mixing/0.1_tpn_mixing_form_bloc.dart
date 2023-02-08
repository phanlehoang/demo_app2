import 'dart:async';

import 'package:demo_app2/data/models/TPN/3_TPN_procedure_online_cubit.dart';
import 'package:demo_app2/data/models/medical/2.1_medical_mixing.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class TPNMixingFormBloc extends FormBloc<String, String> {
  final TPNProcedureOnlineCubit tpnProcedureOnlineCubit;

  TPNMixingFormBloc({required this.tpnProcedureOnlineCubit});

  @override
  FutureOr<void> onSubmitting() async {
    MedicalMixing medicalMixing = MedicalMixing(time: DateTime.now());
    try {
      await tpnProcedureOnlineCubit.addMedicalAction(medicalMixing);
      emitSuccess();
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
  }
}
