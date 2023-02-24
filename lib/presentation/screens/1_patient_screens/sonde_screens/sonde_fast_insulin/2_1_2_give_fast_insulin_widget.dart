// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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
import '../../../../../data/models/models_export.dart';
import '../../../../../data/models/sonde/7.2_sonde_procedure_online_cubit.dart';
import '../../../../../logic/1_patient_blocs/medical_blocs/sonde_blocs/check_insulin_submit_bloc.dart';

import '../../../../widgets/nice_widgets/1_nice_container.dart';
import '2_1_1_check_glucose_widget.dart';

class GiveInsulinWidget extends StatelessWidget {
  //sonde cubit
  final SondeProcedureOnlineCubit sondeProcedureOnlineCubit;
  const GiveInsulinWidget({
    Key? key,
    required this.sondeProcedureOnlineCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder(
          bloc: sondeProcedureOnlineCubit,
          builder: (ct, st) {
            final sondeProcedure = sondeProcedureOnlineCubit.state;
            switch (sondeProcedure.fastStatus) {
              case RegimenStatus.givingInsulin:
                {
                  num glu = sondeProcedure.regimens.last.lastGluAmount;
                  String guide = GlucoseSolve.insulinGuideString(
                    regimen: sondeProcedure.regimens.last,
                    sondeState: sondeProcedureOnlineCubit.state.state,
                  );
                  String plusGuide = GlucoseSolve.plusInsulinGuide(glu);
                  num plus = GlucoseSolve.plusInsulinAmount(glu);
                  if (plus == 4 &&
                      sondeProcedure.state.status ==
                          ProcedureStatus.highInsulin) {
                    plus = 6;
                  }
                  num insulin = GlucoseSolve.insulinGuide(
                    regimen: sondeProcedure.regimens.last,
                    sondeState: sondeProcedureOnlineCubit.state.state,
                  );
                  return Column(
                    children: [
                      Text('Tạm ngừng thuốc hạ đường máu'),
                      Text(plusGuide),
                      Text(guide),
                      BlocProvider<CheckedInsulinSubmit>(
                          create: (context) => CheckedInsulinSubmit(
                                procedureOnlineCubit: sondeProcedureOnlineCubit,
                                medicalTakeInsulin: MedicalTakeInsulin(
                                  time: DateTime.now(),
                                  insulinType: InsulinType.Actrapid,
                                  insulinUI: insulin,
                                ),
                                plus: plus,
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
                                text: 'Tiếp tục',
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
