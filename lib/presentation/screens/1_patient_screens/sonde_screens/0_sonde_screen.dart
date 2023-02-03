
import 'package:demo_app2/data/models/sonde/7.2_sonde_procedure_online_cubit.dart';
import 'package:demo_app2/logic/status_cubit/time_check/time_check_cubit.dart';
import 'package:demo_app2/presentation/screens/1_patient_screens/sonde_screens/1_sonde_status_widget.dart';
import 'package:demo_app2/presentation/widgets/images/doctor_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_buttons/nice_buttons.dart';

import '../../../../data/models/time_controller/2_sonde_range.dart';
import '../../../widgets/nice_widgets/nice_export.dart';
import '../history_widget/5_sonde_history_screen.dart';

class InSondeRange extends Cubit<int?> {
  InSondeRange(int? state) : super(state);
}

class SondeScreen extends StatelessWidget {
  final SondeProcedureOnlineCubit sondeProcedureOnlineCubit;
  const SondeScreen({super.key,
    required this.sondeProcedureOnlineCubit,});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InSondeRange>(
      create: (context) => InSondeRange(
        SondeRange(). rangeContainToday(DateTime.now()),
      ),
      child: NiceScreen(
        child: Column(
          children: [
            Text('Phac do Sonde'),
            Row(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DoctorImage(),
                //button to history
                NiceButtons(
                  onTap: (f) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) 
                        => SondeHistoryScreen(
                          sondeProcedureOnlineCubit: sondeProcedureOnlineCubit,))
                    );
                  },
                  stretch: false ,
                  width: 50,
                  endColor: Colors.yellow,
                  startColor: Colors.yellow.shade200,
                  // tạo icon history
                   child: Icon(Icons.history),
                ),
              ],
            ),
            BlocBuilder<TimeCheckCubit, int>(
              builder: (context, state) {
                DateTime t = DateTime.now();
                context.read<InSondeRange>().emit(SondeRange().rangeContain(t));
                return Text(t.toString());
              },
            ),
            BlocBuilder<InSondeRange, int?>(
              builder: (context, state) {
                if (state == null) {
                  return Text(SondeRange().waitingMessage(DateTime.now()));
                } else {
                  return SondeStatusWidget(
                    sondeProcedureOnlineCubit: sondeProcedureOnlineCubit,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
