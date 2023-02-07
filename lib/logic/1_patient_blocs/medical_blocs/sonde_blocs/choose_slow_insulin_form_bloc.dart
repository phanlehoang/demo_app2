import 'dart:async';

import 'package:demo_app2/data/models/enum/2_string_to_enum.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../data/models/sonde/7.2_sonde_procedure_online_cubit.dart';
import '../../../../presentation/widgets/vietnamese/vietnamese_field_bloc_validators.dart';

class ChooseSlowInsulinFormBloc extends FormBloc<String, String> {
  final SondeProcedureOnlineCubit sondeProcedureOnlineCubit;
  final slowInsulin = SelectFieldBloc(
    items: ['NPH', 'Glargine'],
    validators: [VietnameseFieldBlocValidators.required],
  );
  //add field bloc
  @override
  ChooseSlowInsulinFormBloc({
    required this.sondeProcedureOnlineCubit,
  }) {
    addFieldBlocs(fieldBlocs: [
      slowInsulin,
    ]);
  }

  @override
  Future<void> onSubmitting() async {
    try {
      await sondeProcedureOnlineCubit.procedureRef.update({
        'slowInsulinType': slowInsulin.value,
      });
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
    emitSuccess();
  }
}
