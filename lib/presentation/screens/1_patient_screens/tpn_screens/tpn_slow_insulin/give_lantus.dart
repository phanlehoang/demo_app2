import 'package:demo_app2/data/models/enum/enums.dart';
import 'package:demo_app2/data/models/glucose-insulin_controller/sonde_slow_insulin_solve.dart';
import 'package:demo_app2/data/models/medical/3_medical_take_insulin.dart';
import 'package:demo_app2/data/models/time_controller/2_sonde_range.dart';
import 'package:demo_app2/logic/1_patient_blocs/medical_blocs/sonde_blocs/check_insulin_submit_bloc.dart';
import 'package:demo_app2/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../../data/models/medical/6_procedure_state.dart';
import '../../../../../data/models/sonde/7.2_sonde_procedure_online_cubit.dart';
import '../../../../../data/models/time_controller/3_TPN_range.dart';
import '../../../../widgets/nice_widgets/2_nice_button.dart';

class GiveLantus extends StatelessWidget {
  //add sondeProcedureOnlineCubit
  final tpnProcedureOnlineCubit;
  const GiveLantus({
    Key? key,
    required this.tpnProcedureOnlineCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    int? range = LantusRange().rangeContainToday(DateTime.now());
    if (range != null) {
      switch (tpnProcedureOnlineCubit.state.slowStatus) {
        case RegimenStatus.done:
          return Column(
            children: [
              //message to next time range
              Text(LantusRange().waitingMessage(DateTime.now())),
            ],
          );
        case RegimenStatus.givingInsulin:
          return GuideLantus(
            tpnProcedureOnlineCubit: tpnProcedureOnlineCubit,
          );
        default:
      }
    }
    return Text(LantusRange().waitingMessage(DateTime.now()));
  }
}

class GuideLantus extends StatelessWidget {
  final tpnProcedureOnlineCubit;
  const GuideLantus({
    Key? key,
    required this.tpnProcedureOnlineCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProcedureState sondeState = tpnProcedureOnlineCubit.state.state;
    num insulinAmount =
        LantusInsulinSolve().insulinAmount(sondeState: sondeState);
    String guide = LantusInsulinSolve().guide(sondeState: sondeState);

    final CheckedInsulinSubmit checkedInsulinSubmitBloc = CheckedInsulinSubmit(
        procedureOnlineCubit: tpnProcedureOnlineCubit,
        medicalTakeInsulin: MedicalTakeInsulin(
            insulinType: InsulinType.Lantus,
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
          //nice button tiêm xong
          NiceButton(
              onTap: () {
                checkedInsulinSubmitBloc.submit();
              },
              text: ('Tiêm xong')),
        ],
      )),
    );
  }
}
