import 'package:demo_app2/data/models/enum/enums.dart';
import 'package:demo_app2/logic/status_cubit/time_check/time_check_cubit.dart';
import 'package:demo_app2/presentation/screens/1_patient_screens/TPN_screens/1_TPN_status_widget.dart';
import 'package:demo_app2/presentation/screens/1_patient_screens/history_widget/nice_date_time.dart';
import 'package:demo_app2/presentation/screens/1_patient_screens/tpn_screens/tpn_mixing/1_tpn_mixing_widget.dart';
import 'package:demo_app2/presentation/widgets/images/doctor_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_buttons/nice_buttons.dart';

import '../../../../data/models/TPN/3_TPN_procedure_online_cubit.dart';
import '../../../../data/models/time_controller/2_sonde_range.dart';
import '../../../widgets/nice_widgets/nice_export.dart';
import '../history_widget/6_tpn_history_screen.dart';

class InTPNRange extends Cubit<int?> {
  InTPNRange(int? state) : super(state);
  void update(int? state) {
    emit(state);
  }
}

class TPNScreen extends StatelessWidget {
  final TPNProcedureOnlineCubit tPNProcedureOnlineCubit;
  const TPNScreen({
    super.key,
    required this.tPNProcedureOnlineCubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InTPNRange>(
      create: (context) => InTPNRange(
        ActrapidRange().rangeContainToday(DateTime.now()),
      ),
      child: NiceScreen(
        child: Column(
          children: [
            Text('Phác đồ TPN'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DoctorImage(),
                //button to history
                NiceButtons(
                  onTap: (f) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => TPNHistoryScreen(
                                  tPNProcedureOnlineCubit:
                                      tPNProcedureOnlineCubit,
                                )));
                  },
                  stretch: false,
                  width: 50,
                  endColor: Colors.yellow,
                  startColor: Colors.yellow.shade200,
                  // tạo icon history
                  child: Icon(Icons.history),
                ),
              ],
            ),
            BlocBuilder(
                bloc: tPNProcedureOnlineCubit,
                builder: (ct, st) {
                  final tPNProcedureState = tPNProcedureOnlineCubit.state;
                  if (tPNProcedureState.state.status ==
                      ProcedureStatus.finish) {
                    return Text('Phác đồ này đã xong');
                  }
                  return TPNDoing(
                    tpnProcedureOnlineCubit: tPNProcedureOnlineCubit,
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class TPNDoing extends StatelessWidget {
  const TPNDoing({
    super.key,
    required this.tpnProcedureOnlineCubit,
  });

  final TPNProcedureOnlineCubit tpnProcedureOnlineCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<TimeCheckCubit, int>(
          builder: (context, state) {
            DateTime t = DateTime.now();
            context.read<InTPNRange>().update(ActrapidRange().rangeContain(t));
            return Text(NiceDateTime.yearMonthDayHourMinuteSecond(t));
          },
        ),
        BlocBuilder<InTPNRange, int?>(
          builder: (context, state) {
            return BlocBuilder(
                bloc: tpnProcedureOnlineCubit,
                builder: (ct, st) {
                  if (tpnProcedureOnlineCubit.state.state.status ==
                      ProcedureStatus.firstAsk)
                    return Text('');
                  else
                    return TPNMixingWidget(
                        tpnProcedureOnlineCubit: tpnProcedureOnlineCubit);
                });
          },
        ),
        BlocBuilder<InTPNRange, int?>(
          builder: (context, state) {
            if (state == null) {
              return Text(ActrapidRange().waitingMessage(DateTime.now()));
            } else {
              return Column(
                children: [
                  TPNStatusWidget(
                      tpnProcedureOnlineCubit: tpnProcedureOnlineCubit),
                ],
              );
            }
          },
        ),
      ],
    );
  }
}
