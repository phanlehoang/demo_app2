import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/data/data_provider/sonde_provider/sonde_state_provider.dart';
import 'package:demo_app2/data/models/enum/enums.dart';

import 'package:demo_app2/presentation/screens/1_patient_screens/tpn_screens/tpn_fast_insulin/tpn_fast_insulin_widget.dart';
import 'package:demo_app2/presentation/screens/1_patient_screens/tpn_screens/tpn_mixing/1_tpn_mixing_widget.dart';
import 'package:demo_app2/presentation/screens/1_patient_screens/tpn_screens/tpn_slow_insulin/tpn_slow_insulin.dart';
import 'package:demo_app2/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/2.3_current_profile_cubit.dart';
import '../../../../data/models/2.TPN/1_TPN_procedure.dart';
import '../../../../data/models/2.TPN/3_TPN_procedure_online_cubit.dart';
import '../../../../data/models/medical/7_medical_procedure.dart';
import '../../../../data/models/models_export.dart';
import '../../../widgets/nice_widgets/0.1_nice_internet_screen.dart';
import '2_tpn_first_ask_widget.dart';

class TPNStatusWidget extends StatelessWidget {
  final TPNProcedureOnlineCubit tpnProcedureOnlineCubit;
  TPNStatusWidget({
    super.key,
    required this.tpnProcedureOnlineCubit,
  });

  @override
  Widget build(BuildContext context) {
    final Profile profile = context.read<CurrentProfileCubit>().state;

    return NiceInternetScreen(
      child: Column(children: [
        BlocBuilder(
          bloc: tpnProcedureOnlineCubit,
          builder: (ct, st) {
            final tpnProcedure = st as MedicalProcedure;
            switch (tpnProcedure.state.status) {
              case ProcedureStatus.firstAsk:
                return TPNFirstAskWidget(
                    procedureOnlineCubit: tpnProcedureOnlineCubit);
              case ProcedureStatus.noInsulin:
                return Column(
                  children: [
                    TPNFastInsulinWidget(
                        procedureOnlineCubit: tpnProcedureOnlineCubit)
                  ],
                );
              //yesInsulin
              case ProcedureStatus.yesInsulin:
                return Column(
                  children: [
                    TPNSlowInsulinWidget(
                        procedureOnlineCubit: tpnProcedureOnlineCubit),
                    TPNFastInsulinWidget(
                        procedureOnlineCubit: tpnProcedureOnlineCubit)
                  ],
                );
              //highInsulin
              case ProcedureStatus.highInsulin:
                return Column(
                  children: [
                    TPNSlowInsulinWidget(
                        procedureOnlineCubit: tpnProcedureOnlineCubit),
                    TPNFastInsulinWidget(
                        procedureOnlineCubit: tpnProcedureOnlineCubit)
                  ],
                );
              case ProcedureStatus.finish:
                return Text('Chuyển sang phác đồ bơm điện');
              default:
                return Container();
            }
          },
        ),
      ]),
    );
  }
}
