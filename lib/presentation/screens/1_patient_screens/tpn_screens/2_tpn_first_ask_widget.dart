import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/data/data_provider/sonde_provider/sonde_state_provider.dart';
import 'package:demo_app2/data/models/enum/enums.dart';
import 'package:demo_app2/data/models/sonde/sonde_lib.dart';
import 'package:demo_app2/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:demo_app2/presentation/widgets/vietnamese/vietnamese_field_bloc_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../data/models/sonde/7.2_sonde_procedure_online_cubit.dart';
import '../../../widgets/nice_widgets/1_nice_container.dart';
import '../../../widgets/nice_widgets/2_nice_button.dart';

class TPNFirstAskWidget extends StatelessWidget {
  final procedureOnlineCubit;
  const TPNFirstAskWidget({
    Key? key,
    required this.procedureOnlineCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // BlocBuilder(
        //   bloc: sondeProcedureOnlineCubit,
        //   builder: (context, state) {
        //     return Text(state.toString());
        //   },
        // ),
        //first ask form
        BlocProvider<TPNFirstAskBloc>(
            create: (context) => TPNFirstAskBloc(
                  procedureOnlineCubit: procedureOnlineCubit,
                ),
            child: Builder(
              builder: (context) {
                final formBloc = context.read<TPNFirstAskBloc>();
                return FormBlocListener<TPNFirstAskBloc, String, String>(
                  onSubmitting: (context, state) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  //fail
                  onFailure: (context, state) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('error'),
                      ),
                    );
                  },
                  onSuccess: (context, state) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('success'),
                      ),
                    );
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text('Bạn có tiêm insulin không?'),
                        RadioButtonGroupFieldBlocBuilder(
                          selectFieldBloc: formBloc.yesOrNoInsulin,
                          itemBuilder: (context, value) =>
                              FieldItem(child: Text(value)),
                        ),
                        NiceButton(
                          onTap: formBloc.submit,
                          text: 'Tiếp tục',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ))
      ],
    );
  }
}

class TPNFirstAskBloc extends FormBloc<String, String> {
  final procedureOnlineCubit;
  final yesOrNoInsulin = SelectFieldBloc(
    items: ['Yes', 'No'],
    validators: [VietnameseFieldBlocValidators.required],
  );

  TPNFirstAskBloc({
    required this.procedureOnlineCubit,
  }) {
    addFieldBlocs(
      fieldBlocs: [
        yesOrNoInsulin,
      ],
    );
  }

  @override
  void onSubmitting() async {
    print('onSubmitting');
    ProcedureStatus sondeStatus = yesOrNoInsulin.value == 'Yes'
        ? ProcedureStatus.yesInsulin
        : ProcedureStatus.noInsulin;
    //update sonde status
    try {
      await procedureOnlineCubit.updateProcedureStateStatus(ProcedureState(
        status: sondeStatus,
        weight: procedureOnlineCubit.profile.weight,
      ));
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
    emitSuccess();
  }
}
