//tao 1 trang history có attribute la sondeProcedureOnlineCubit

//import material 
import 'package:demo_app2/data/models/medical/4_regimen.dart';
import 'package:demo_app2/data/models/sonde/7.2_sonde_procedure_online_cubit.dart';
import 'package:demo_app2/presentation/screens/1_patient_screens/procedures_screens/nice_date_time.dart';
import 'package:demo_app2/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/nice_widgets/6_nice_item.dart';
import '../../../widgets/nice_widgets/nice_export.dart';
import '../history_widget/medical_action_item.dart';
import '../history_widget/regimen_item.dart';

class SondeHistoryScreen extends StatelessWidget {
  final SondeProcedureOnlineCubit sondeProcedureOnlineCubit;
  const SondeHistoryScreen({super.key,
    required this.sondeProcedureOnlineCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: BlocBuilder(
        bloc: sondeProcedureOnlineCubit,
        builder: (context, state) {
          final st = sondeProcedureOnlineCubit.state;
          String first = NiceDateTime.dayMonthYear(st.beginTime);
          String last = NiceDateTime.dayMonthYear(st.lastTime);
        return NiceInternetScreen(
          child: Column(children: [
            //tat ca regimen 
            NiceContainer(child: 
            Column(
              children: [
                Text('Sonde Procedure'),
                 
            Text(' $first - $last'),
            Text('Cân nặng bệnh nhân: ${st.state.weight} kg'),
            Text('Lượng cho: ${st.state.cho} ml'),
              ],
            )
            ),
                         SizedBox(height: 20,),

            for (var regimen in sondeProcedureOnlineCubit.state.regimens.reversed)
            RegimenItem(regimen: regimen),
          ],),
        );
    
      }
      ),
    );
  }
}

