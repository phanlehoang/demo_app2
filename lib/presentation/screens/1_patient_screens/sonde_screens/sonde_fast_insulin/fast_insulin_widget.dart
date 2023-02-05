// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/data/models/sonde/7.2_sonde_procedure_online_cubit.dart';
import 'package:demo_app2/logic/status_cubit/time_check/time_check_cubit.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:demo_app2/data/data_provider/regimen_provider.dart';
import 'package:demo_app2/data/models/models_export.dart';
import 'package:demo_app2/presentation/widgets/nice_widgets/0_nice_screen.dart';

import '../../../../../data/models/2.3_current_profile_cubit.dart';
import '../../../../../data/models/enum/enums.dart';

import '../../../../../data/models/time_controller/2_sonde_range.dart';
import '../../../../widgets/nice_widgets/1_nice_container.dart';
import '2_1_1_check_glucose_widget.dart';
import '2_1_2_give_fast_insulin_widget.dart';

class FastInsulinWidget extends StatelessWidget {
  final SondeProcedureOnlineCubit sondeProcedureOnlineCubit;
  const FastInsulinWidget({
    Key? key,
    required this.sondeProcedureOnlineCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Profile profile = context.read<CurrentProfileCubit>().state;
    return SimpleContainer(
      child: Column(
        children: [
           Text('FastInsulinWidget'),
          BlocBuilder(
            bloc: sondeProcedureOnlineCubit,
            builder: (context, state) {
              return Column(
                children: [
                  // Text(state.toString()),
                  // Text(sondeProcedureOnlineCubit.state.fastStatus.toString()),
                  Builder(builder: (ct2){
                    switch (sondeProcedureOnlineCubit.state.fastStatus) {
                      case RegimenStatus.checkingGlucose:
                        return CheckGlucoseWidget(
                          sondeProcedureOnlineCubit: sondeProcedureOnlineCubit,
                        );
                       case RegimenStatus.givingInsulin:
                        return GiveInsulinWidget(
                          sondeProcedureOnlineCubit: sondeProcedureOnlineCubit,
                        );
                         
                        case RegimenStatus.done:
                        {
                          if(sondeProcedureOnlineCubit.state.isFull50 &&
                           sondeProcedureOnlineCubit.state.slowStatus == RegimenStatus.done){
                            sondeProcedureOnlineCubit.goToNextStatus();
                          }
                          return Column(
                          children: [
                            Text('Done'),
                            Text(ActrapidRange().waitingMessage(DateTime.now()) ),
                          ],
                        );
                        }
                        
                      default:
                        return Text('default'); 

                    }

                  })
                ],
              );
            },
          ),
         
        ],
      ),
    );
  }
}


