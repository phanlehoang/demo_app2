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

class FirstAskWidget extends StatelessWidget {
  final SondeProcedureOnlineCubit sondeProcedureOnlineCubit;
  const FirstAskWidget({
    Key? key,
    required this.sondeProcedureOnlineCubit,
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
        BlocProvider<FirstAskBloc>(
            create: (context) => FirstAskBloc(
                 
                sondeProcedureOnlineCubit: sondeProcedureOnlineCubit,
                
                ),
            child: Builder(
              builder: (context) {
                final formBloc = context.read<FirstAskBloc>();
                return FormBlocListener<FirstAskBloc, String, String>(
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
                        Text('Nhập số lượng CHO'),
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.getCHO,
                          keyboardType: TextInputType.number,
                        ),
                        ElevatedButton(
                          onPressed: formBloc.submit,
                          child: Text('Tiếp tục'),
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

class FirstAskBloc extends FormBloc<String, String> {
  final SondeProcedureOnlineCubit sondeProcedureOnlineCubit;
  final yesOrNoInsulin = SelectFieldBloc(
    items: ['Yes', 'No'],
    validators: [VietnameseFieldBlocValidators.required],
  );
  final getCHO = TextFieldBloc(
    validators: [VietnameseFieldBlocValidators.required],
  );

  FirstAskBloc({
    required this.sondeProcedureOnlineCubit,
  }) {
    addFieldBlocs(
      fieldBlocs: [
        yesOrNoInsulin,
        getCHO,
      ],
    );
  }

  @override
  void onSubmitting() async {
    print('onSubmitting');
    SondeStatus sondeStatus = yesOrNoInsulin.value == 'Yes'
        ? SondeStatus.yesInsulin
        : SondeStatus.noInsulin;
    //update sonde status
    try 
    {
      await sondeProcedureOnlineCubit.updateSondeStateStatus(
        SondeState(status: sondeStatus,
        cho: num.parse(getCHO.value),
        weight: sondeProcedureOnlineCubit.profile.weight,
        )
      );
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
    emitSuccess();
   
  }
}