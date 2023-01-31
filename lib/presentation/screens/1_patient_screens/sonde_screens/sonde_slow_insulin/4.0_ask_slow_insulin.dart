import 'package:demo_app2/data/models/sonde/7.2_sonde_procedure_online_cubit.dart';
import 'package:demo_app2/logic/1_patient_blocs/medical_blocs/sonde_blocs/choose_slow_insulin_form_bloc.dart';
import 'package:demo_app2/presentation/widgets/nice_widgets/2_nice_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class AskSlowInsulin extends StatelessWidget {
  final SondeProcedureOnlineCubit sondeProcedureOnlineCubit;
  const AskSlowInsulin({
    Key? key,
    required this.sondeProcedureOnlineCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(_)=>  ChooseSlowInsulinFormBloc(
        sondeProcedureOnlineCubit: sondeProcedureOnlineCubit),
      child: Builder(
        builder: (ct){
          final ChooseSlowInsulinFormBloc chooseSlowInsulinFormBloc = ct.read<ChooseSlowInsulinFormBloc>();
          return BlocBuilder(
            bloc: chooseSlowInsulinFormBloc,
            builder: (ct1, st1){
              return Column(
                children: [
                  Text('Chon loai tiem cham'),
                  FormBlocListener(
                    formBloc: chooseSlowInsulinFormBloc,
                    onSubmitting: (ct, st) {
                       //LoadingDialog.show(ct);
                    },
                    onSuccess: (ct, st)  {
                     // LoadingDialog.hide(ct);
                      ScaffoldMessenger.of(ct).showSnackBar(
                        SnackBar(
                          content: Text('Success'),
                        ),
                      );
                    },
                    onFailure: (ct, st) => {
                     // LoadingDialog.hide(ct),
                      ScaffoldMessenger.of(ct).showSnackBar(
                        SnackBar(
                          content: Text('Failure'),
                        ),
                      ),
                    },
                    child: Column(children: [
                      RadioButtonGroupFieldBlocBuilder(
                        selectFieldBloc: chooseSlowInsulinFormBloc.slowInsulin,
                        itemBuilder: (context, value) => FieldItem(child: Text(value)),
            decoration: const InputDecoration(
                labelText: 'Loai insulin', prefixIcon: SizedBox()),
          ),
                      NiceButton(
                        onTap: chooseSlowInsulinFormBloc.submit,
                        text: 'Xác nhận',
                      ),

                    ]),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

                  