import 'package:demo_app2/data/models/enum/enums.dart';
import 'package:demo_app2/data/models/glucose-insulin_controller/sonde_slow_insulin_solve.dart';
import 'package:demo_app2/data/models/medical/3_medical_take_insulin.dart';
import 'package:demo_app2/data/models/time_controller/2_sonde_range.dart';
import 'package:demo_app2/logic/1_patient_blocs/medical_blocs/sonde_blocs/check_insulin_submit_bloc.dart';
import 'package:demo_app2/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../../data/models/1.sonde/7.2_sonde_procedure_online_cubit.dart';
import '../../../../../data/models/medical/6_procedure_state.dart';
import '../../../../widgets/nice_widgets/2_nice_button.dart';

class GiveNPH extends StatelessWidget {
  //add sondeProcedureOnlineCubit
  final SondeProcedureOnlineCubit sondeProcedureOnlineCubit;
  const GiveNPH({
    Key? key,
    required this.sondeProcedureOnlineCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    int? range = NPHRange().rangeContainToday(DateTime.now());
    if (range != null) {
      switch (sondeProcedureOnlineCubit.state.slowStatus) {
        case RegimenStatus.done:
          return Column(
            children: [
              Text('Đã tiêm xong NPH.'),
              //message next time
              Text(NPHRange().waitingMessage(DateTime.now())),
            ],
          );
        case RegimenStatus.givingInsulin:
          return GuideNPH(
            sondeProcedureOnlineCubit: sondeProcedureOnlineCubit,
          );
        default:
      }
    }
    return Text(NPHRange().waitingMessage(DateTime.now()));
  }
}

class GuideNPH extends StatelessWidget {
  final SondeProcedureOnlineCubit sondeProcedureOnlineCubit;
  const GuideNPH({
    Key? key,
    required this.sondeProcedureOnlineCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProcedureState sondeState = sondeProcedureOnlineCubit.state.state;
    num insulinAmount = NPHInsulinSolve().insulinAmount(sondeState: sondeState);
    String guide = NPHInsulinSolve().guide(sondeState: sondeState);

    final CheckedInsulinSubmit checkedInsulinSubmitBloc = CheckedInsulinSubmit(
        procedureOnlineCubit: sondeProcedureOnlineCubit,
        medicalTakeInsulin: MedicalTakeInsulin(
            insulinType: InsulinType.NPH,
            time: DateTime.now(),
            insulinUI: insulinAmount));

    return FormBlocListener(
      formBloc: checkedInsulinSubmitBloc,
      onFailure: (ct, st) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Ko cap nhat duoc database')));
      },
      child: NiceScreen(
          child: Column(
        children: [
          Text('Hướng dẫn: $guide'),
          NiceButton(
              text: 'Tiêm xong',
              onTap: () {
                checkedInsulinSubmitBloc.submit();
              }),
        ],
      )),
    );
  }
}
