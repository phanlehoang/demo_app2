import 'package:demo_app2/data/data_provider/patient_provider.dart';
import 'package:demo_app2/data/models/enum/enums.dart';
import 'package:demo_app2/data/models/sonde/7_sonde_procedure.dart';
import 'package:demo_app2/logic/status_cubit/time_check/time_check_cubit.dart';
import 'package:demo_app2/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../data/models/2.3_current_profile_cubit.dart';
import '../../../data/models/2_profile.dart';
import '../../../data/models/sonde/7.2_sonde_procedure_online_cubit.dart';
import '../../widgets/bars/bottom_navitgator_bar.dart';
import '../../widgets/bars/patient_navigator_bar.dart';
import '../../widgets/nice_widgets/0.1_nice_internet_screen.dart';
import '../../widgets/status/loading_dialog.dart';
import 'sonde_screens/0_sonde_screen.dart';

class PatientMedicalScreen extends StatelessWidget {
  const PatientMedicalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: PatientNavigatorBar(),
      ),
      body: NiceInternetScreen(
        child: Column(
          children: [
            BlocBuilder<CurrentProfileCubit, Profile>(builder: (ct, st) {
              //sonde procedure bloc
              String sondeProcedureId = st.currentProcedureId;
              switch (st.procedureType) {
                case ProcedureType.Sonde:
                  return SondeScreen(
                    sondeProcedureOnlineCubit: SondeProcedureOnlineCubit(
                      profile: context.read<CurrentProfileCubit>().state,
                      procedureId: sondeProcedureId,
                    ),
                  );
                case ProcedureType.TPN:
                  return Text('TPN');
                case ProcedureType.Unknown:
                  return Text('Unknown');

                default:
                  return Container();
              }
            }),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigatorBar(),
    );
  }
}
