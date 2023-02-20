import 'package:demo_app2/logic/1_patient_blocs/medical_blocs/sonde_blocs/choose_slow_insulin_form_bloc.dart';
import 'package:demo_app2/presentation/screens/1_patient_screens/sonde_screens/sonde_slow_insulin/4.2_give_Glargine.dart';
import 'package:demo_app2/presentation/widgets/nice_widgets/2_nice_button.dart';
import 'package:demo_app2/presentation/widgets/status/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../../data/models/enum/enums.dart';
import '../../../../../data/models/sonde/7.2_sonde_procedure_online_cubit.dart';
import '../../../../widgets/nice_widgets/1_nice_container.dart';
import '4.0_ask_slow_insulin.dart';
import '4.1_give_NPH.dart';

class SlowInsulinWidget extends StatelessWidget {
  final SondeProcedureOnlineCubit sondeProcedureOnlineCubit;
  const SlowInsulinWidget({
    Key? key,
    required this.sondeProcedureOnlineCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleContainer(
      child: Column(
        children: [
          //  Text('Tiem cham'),
          BlocBuilder(
              bloc: sondeProcedureOnlineCubit,
              builder: (ct, st) {
                switch (sondeProcedureOnlineCubit.state.state.slowInsulinType) {
                  case InsulinType.Unknown:
                    return Column(
                      children: [
                        Text('chọn loại insulin'),
                        AskSlowInsulin(
                          sondeProcedureOnlineCubit: sondeProcedureOnlineCubit,
                        ),
                      ],
                    );
                  case InsulinType.NPH:
                    return GiveNPH(
                      sondeProcedureOnlineCubit: sondeProcedureOnlineCubit,
                    );
                  case InsulinType.Glargine:
                    return GiveGlargine(
                        sondeProcedureOnlineCubit: sondeProcedureOnlineCubit);
                  default:
                    return Text('Chua biet');
                }
              })
        ],
      ),
    );
  }
}
