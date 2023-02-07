// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/data/models/TPN/3_TPN_procedure_online_cubit.dart';
import 'package:demo_app2/data/models/medical/3_medical_take_insulin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import 'package:demo_app2/data/models/sonde/sonde_lib.dart';
import 'package:demo_app2/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:demo_app2/presentation/widgets/nice_widgets/2_nice_button.dart';

import '../../../../../data/data_provider/regimen_provider.dart';
import '../../../../../data/models/enum/enums.dart';
import '../../../../../data/models/glucose-insulin_controller/glucose_solve.dart';
import '../../../../../data/models/glucose-insulin_controller/tpn_glucose_solve.dart';
import '../../../../../data/models/models_export.dart';
import '../../../../../data/models/sonde/7.2_sonde_procedure_online_cubit.dart';
import '../../../../../logic/1_patient_blocs/medical_blocs/sonde_blocs/check_insulin_submit_bloc.dart';

import '../../../../widgets/nice_widgets/1_nice_container.dart';

class TPNGiveFastInsulinWidget extends StatelessWidget {
  //sonde cubit
  final TPNProcedureOnlineCubit tpnProcedureOnlineCubit;
  const TPNGiveFastInsulinWidget({
    Key? key,
    required this.tpnProcedureOnlineCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder(
          bloc: tpnProcedureOnlineCubit,
          builder: (ct, st) {
            final tpnProcedure = tpnProcedureOnlineCubit.state;
            switch (tpnProcedure.fastStatus) {
              case RegimenStatus.givingInsulin:
                {
                  num glu = tpnProcedure.regimens.last.lastGluAmount;
                  String guide = TPNGlucoseSolve.insulinGuideString(
                    regimen: tpnProcedure.regimens.last,
                    procedureState: tpnProcedureOnlineCubit.state.state,
                  );

                  num insulin = GlucoseSolve.insulinGuide(
                    regimen: tpnProcedure.regimens.last,
                    sondeState: tpnProcedureOnlineCubit.state.state,
                  );
                  return Column(
                    children: [
                      Text('Tạm ngừng thuốc hạ đường máu'),
                      Text(guide),
                      BlocProvider<CheckedInsulinSubmit>(
                          create: (context) => CheckedInsulinSubmit(
                                procedureOnlineCubit: tpnProcedureOnlineCubit,
                                medicalTakeInsulin: MedicalTakeInsulin(
                                  time: DateTime.now(),
                                  insulinType: InsulinType.Actrapid,
                                  insulinUI: insulin,
                                ),
                              ),
                          child: Builder(builder: (_) {
                            return FormBlocListener<CheckedInsulinSubmit,
                                String, String>(
                              onSuccess: (cc, state) {
                                ScaffoldMessenger.of(cc).showSnackBar(
                                  SnackBar(
                                    content: Text('Success'),
                                  ),
                                );
                              },
                              onFailure: (cc, state) {
                                ScaffoldMessenger.of(cc).showSnackBar(
                                  SnackBar(
                                    content: Text('Failure'),
                                  ),
                                );
                              },
                              child: NiceButton(
                                text: 'Tiếp tục',
                                onTap: () {
                                  _.read<CheckedInsulinSubmit>().submit();
                                },
                              ),
                            );
                          }))
                    ],
                  );
                }

              default:
                {
                  return Text('Co loi xay ra');
                }
            }
          },
        )
      ],
    );
  }
}
