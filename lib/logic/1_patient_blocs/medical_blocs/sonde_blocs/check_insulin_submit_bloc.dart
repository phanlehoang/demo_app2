import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/data/models/medical/3_medical_take_insulin.dart';
import 'package:demo_app2/data/models/sonde/7.2_sonde_procedure_online_cubit.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../data/models/enum/enums.dart';


class CheckedInsulinSubmit extends FormBloc<String, String> {
  final MedicalTakeInsulin medicalTakeInsulin;
   num plus;
  final SondeProcedureOnlineCubit sondeProcedureOnlineCubit;

  CheckedInsulinSubmit({
    required this.sondeProcedureOnlineCubit,
    required this.medicalTakeInsulin,
     this.plus : 0,
  });
  @override
  Future<void> onSubmitting() async {
    try {
      sondeProcedureOnlineCubit.addMedicalAction(medicalTakeInsulin);
      final profile = sondeProcedureOnlineCubit.profile;
      var updateBonus = await FirebaseFirestore.instance
          .collection('groups')
          .doc(profile.room)
          .collection('patients')
          .doc(profile.id)
          .collection('procedures')
          .doc(sondeProcedureOnlineCubit.procedureId)
          .update({'bonusInsulin': FieldValue.increment(plus)});
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
    emitSuccess();
  }
}
