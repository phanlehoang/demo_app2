

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

class GiveGlargine extends StatelessWidget {
  //add sondeProcedureOnlineCubit
  final SondeProcedureOnlineCubit sondeProcedureOnlineCubit;
  const GiveGlargine({
    Key? key,
    required this.sondeProcedureOnlineCubit,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    int? range = GlargineRange().rangeContainToday(DateTime.now());
    if(range != null){
       switch (sondeProcedureOnlineCubit.state.slowStatus) {
         case RegimenStatus.done:
            return Text('Bạn đã tiêm cham xong');
          case RegimenStatus.givingInsulin:
            return GuideGlargine(
              sondeProcedureOnlineCubit: sondeProcedureOnlineCubit,
            );
         default:
       }
    }
    return Text(GlargineRange().waitingMessage(DateTime.now()));
  }
  
}

class GuideGlargine extends StatelessWidget {
  final SondeProcedureOnlineCubit sondeProcedureOnlineCubit;
  const GuideGlargine({
    Key? key,
    required this.sondeProcedureOnlineCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     ProcedureState sondeState = sondeProcedureOnlineCubit.state.state;
    num insulinAmount = GlargineInsulinSolve().insulinAmount(sondeState: sondeState);
    String guide = GlargineInsulinSolve().guide(sondeState: sondeState);

    final CheckedInsulinSubmit checkedInsulinSubmitBloc = 
    CheckedInsulinSubmit(
      sondeProcedureOnlineCubit: sondeProcedureOnlineCubit,
      medicalTakeInsulin: MedicalTakeInsulin(
        insulinType: InsulinType.Glargine,
         time: DateTime.now(),
          insulinUI: insulinAmount));
   
   
    return FormBlocListener(
      formBloc: checkedInsulinSubmitBloc,
      onFailure: (ct, st) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ko cap nhat duoc database'))
        );
      },
      child: NiceScreen(child: Column(
        children: [
          Text('Hướng dẫn: $guide'),
          ElevatedButton(
            onPressed: () {
              checkedInsulinSubmitBloc.submit();
            },
            child: Text('Tiêm xong'),
          ),
        ],

      )),
    );
  }
}


