//tao 1 trang history có attribute la TPNProcedureOnlineCubit

//import material
import 'package:demo_app2/data/models/medical/4_regimen.dart';
import 'package:demo_app2/presentation/screens/1_patient_screens/procedures_screens/nice_date_time.dart';
import 'package:demo_app2/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/TPN/3_TPN_procedure_online_cubit.dart';
import '../../../widgets/nice_widgets/6_nice_item.dart';
import '../../../widgets/nice_widgets/nice_export.dart';
import 'medical_action_item.dart';
import 'regimen_item.dart';

class TPNHistoryScreen extends StatelessWidget {
  final TPNProcedureOnlineCubit tPNProcedureOnlineCubit;
  const TPNHistoryScreen({
    super.key,
    required this.tPNProcedureOnlineCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: BlocBuilder(
          bloc: tPNProcedureOnlineCubit,
          builder: (context, state) {
            final st = tPNProcedureOnlineCubit.state;
            String first = NiceDateTime.dayMonthYear(st.beginTime);
            String last = NiceDateTime.dayMonthYear(st.lastTime);
            return NiceInternetScreen(
              child: Column(
                children: [
                  //tat ca regimen
                  NiceContainer(
                      child: Column(
                    children: [
                      Text('TPN Procedure'),

                      Text(' $first - $last'),
                      Text('Cân nặng bệnh nhân: ${st.state.weight} kg'),
                      //Text('debug TPNs: ${st.toString()}'),
                    ],
                  )),
                  SizedBox(
                    height: 20,
                  ),

                  for (var regimen
                      in tPNProcedureOnlineCubit.state.regimens.reversed)
                    RegimenItem(regimen: regimen),
                ],
              ),
            );
          }),
    );
  }
}
