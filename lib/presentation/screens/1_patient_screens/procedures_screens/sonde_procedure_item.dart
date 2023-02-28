import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/1.sonde/7.2_sonde_procedure_online_cubit.dart';
import '../../../../data/models/2.3_current_profile_cubit.dart';
import '../../../../data/models/enum/enums.dart';
import '../../../../logic/status_cubit/navigator_bar_cubit.dart';
import '../../../widgets/nice_widgets/nice_export.dart';
import '../history_widget/nice_date_time.dart';

class SondeProcedureItem extends StatelessWidget {
  const SondeProcedureItem({
    Key? key,
    required this.procedure,
    required this.procedureId,
  }) : super(key: key);

  final Map<String, dynamic> procedure;
  final String procedureId;

  @override
  Widget build(BuildContext context) {
    final SondeProcedureOnlineCubit sondeProcedureOnlineCubit =
        SondeProcedureOnlineCubit(
      profile: context.read<CurrentProfileCubit>().state,
      procedureId: procedureId,
    );
    return BlocBuilder(
      bloc: sondeProcedureOnlineCubit,
      builder: (_context, _procedureState) {
        final procedureState = sondeProcedureOnlineCubit.state;
        if (procedureState.name == 'Đang tải') {
          return Text('Loading');
        }
        //nice date time
        String time = NiceDateTime.dayMonth(procedureState.beginTime);
        return BlocBuilder(
            bloc: context.read<CurrentProfileCubit>(),
            builder: (_context, state) {
              final profile = _context.read<CurrentProfileCubit>().state;
              Color color = Theme.of(context).canvasColor;
              if (profile.currentProcedureId ==
                  procedureState.beginTime.toString()) {
                color = //choose color
                    Colors.greenAccent;
              }
              return Column(
                children: [
                  //  Text(profile.currentProcedureId),

                  SimpleContainer(
                    addColor: color,
                    child: Column(
                      children: [
                        // Text(procedureState.toString()),

                        ListTile(
                          title: Text('Sonde'),
                          subtitle: Text(EnumToString.enumToString(
                              procedureState.state.status)),
                          trailing: Text(time),
                          onTap: () {
                            //profile update to current procedure
                            context.read<CurrentProfileCubit>().update(
                              {
                                'currentProcedureId':
                                    procedureState.beginTime.toString(),
                                'procedureType': 'Sonde'
                              },
                            );
                            context.read<PatientNavigatorBarCubit>().update(0);
                            Navigator.of(context)
                                .pushReplacementNamed('/patient');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            });
      },
    );
  }
}
