import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/2.3_current_profile_cubit.dart';
import '../../../../data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import '../../../../data/models/enum/enums.dart';
import '../../../../logic/status_cubit/navigator_bar_cubit.dart';
import '../../../widgets/nice_widgets/nice_export.dart';
import '../history_widget/nice_date_time.dart';

class MouthProcedureItem extends StatelessWidget {
  const MouthProcedureItem({
    Key? key,
    required this.procedure,
    required this.procedureId,
  }) : super(key: key);

  final Map<String, dynamic> procedure;
  final String procedureId;

  @override
  Widget build(BuildContext context) {
    final MouthProcedureOnlineCubit mouthProcedureOnlineCubit =
        MouthProcedureOnlineCubit(
      profile: context.read<CurrentProfileCubit>().state,
      procedureId: procedureId,
    );
    return BlocBuilder(
      bloc: mouthProcedureOnlineCubit,
      builder: (_context, _procedureState) {
        final mouthProcedure = mouthProcedureOnlineCubit.state;
        if (mouthProcedure.name == 'Đang tải' ||
            mouthProcedure.name == 'loading') {
          return Text('Loading');
        }
        //nice date time
        String time = NiceDateTime.dayMonth(mouthProcedure.beginTime);
        return BlocBuilder(
            bloc: context.read<CurrentProfileCubit>(),
            builder: (_context, state) {
              final profile = _context.read<CurrentProfileCubit>().state;
              Color color = Theme.of(context).canvasColor;
              if (profile.currentProcedureId ==
                  mouthProcedure.beginTime.toString()) {
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
                          title: Text('Mouth'),
                          subtitle: Text(
                              EnumToString.enumToString(mouthProcedure.status)),
                          trailing: Text(time),
                          onTap: () {
                            //profile update to current procedure
                            context.read<CurrentProfileCubit>().update(
                              {
                                'currentProcedureId':
                                    mouthProcedure.beginTime.toString(),
                                'procedureType': 'Mouth'
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
