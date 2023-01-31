//tao 1 trang history có attribute la sondeProcedureOnlineCubit

//import material 
import 'package:demo_app2/data/models/medical/4_regimen.dart';
import 'package:demo_app2/data/models/sonde/7.2_sonde_procedure_online_cubit.dart';
import 'package:demo_app2/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/nice_widgets/6_nice_item.dart';
import '../../../widgets/nice_widgets/nice_export.dart';

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
        return NiceInternetScreen(
          child: Column(children: [
            //tat ca regimen 
            for (var regimen in sondeProcedureOnlineCubit.state.regimens)
            RegimenItem(regimen: regimen),
          ],),
        );
    
      }
      ),
    );
  }
}

class RegimenItem extends StatelessWidget{
  final Regimen regimen;
  const RegimenItem({Key? key, required this.regimen,
  }) 
  : super(key: key);
  //build 
  @override
  Widget build (BuildContext context){
    return Column(children: [
       Text('Regimen: ${regimen.name}'),
       for (var medicalAction in regimen.medicalActions)
        MedicalActionItem(medicalAction: medicalAction),
    ],);
  }

}

class MedicalActionItem extends StatelessWidget{
  final  medicalAction;
  const MedicalActionItem({Key? key, required this.medicalAction,
  }) 
  : super(key: key);
  //build 
  @override
  Widget build (BuildContext context){
    return SimpleContainer(
      child: ListTile(
        title: Text('Name: ${medicalAction.runtimeType}'),
        subtitle: Text('Time: ${medicalAction.time}'),
        trailing: Text(''),
      ),
    );
  }

}
