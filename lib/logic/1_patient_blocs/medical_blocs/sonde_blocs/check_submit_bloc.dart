import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/data/models/medical/3_medical_take_insulin.dart';
import 'package:demo_app2/data/models/sonde/7.2_sonde_procedure_online_cubit.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../data/models/enum/enums.dart';


class CheckedSubmit extends FormBloc<String, String> {
  final num insulin;
  final num plus;
  final SondeProcedureOnlineCubit sondeProcedureOnlineCubit;

  CheckedSubmit({
    required this.sondeProcedureOnlineCubit,
    required this.insulin,
    required this.plus,
  });
  @override
  Future<void> onSubmitting() async {
    MedicalTakeInsulin medicalTakeInsulin = MedicalTakeInsulin(
      insulinUI: insulin,
      time: DateTime.now(),
      insulinType: InsulinType.Actrapid,
    );

    try {
      sondeProcedureOnlineCubit.addMedicalAction(medicalTakeInsulin);
      final profile = sondeProcedureOnlineCubit.profile;
      var updateBonus = await FirebaseFirestore.instance
          .collection('groups')
          .doc(profile.room)
          .collection('patients')
          .doc(profile.id)
          .collection('procedures')
          .doc(sondeProcedureOnlineCubit.beginTime.toString())
          .update({'bonusInsulin': FieldValue.increment(plus)});
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
    emitSuccess();
  }
}
