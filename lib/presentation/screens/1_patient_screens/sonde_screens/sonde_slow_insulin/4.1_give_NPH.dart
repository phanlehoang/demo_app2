

import 'package:demo_app2/data/models/enum/enums.dart';
import 'package:demo_app2/data/models/time_controller/sonde_range.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/models/sonde/7.2_sonde_procedure_online_cubit.dart';

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
    int? range = SondeRange.rangeContain(DateTime.now());
    if(range == 0 ||range == 2){
       switch (sondeProcedureOnlineCubit.state.slowStatus) {
         case RegimenStatus.done:
            return Text('Bạn đã tiêm cham xong');
          case RegimenStatus.givingInsulin:
            return Text('Bạn đang tiêm cham');
         default:
       }
    }
    return Container();
  }
  
}
