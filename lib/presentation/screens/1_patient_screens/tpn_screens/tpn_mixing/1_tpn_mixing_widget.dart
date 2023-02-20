import 'package:demo_app2/data/models/TPN/3_TPN_procedure_online_cubit.dart';
import 'package:demo_app2/data/models/enum/enums.dart';
import 'package:demo_app2/data/models/medical/2.1_medical_mixing.dart';
import 'package:demo_app2/data/models/time_controller/3_TPN_range.dart';
import 'package:demo_app2/presentation/screens/1_patient_screens/tpn_screens/tpn_mixing/0.1_tpn_mixing_form_bloc.dart';
import 'package:demo_app2/presentation/screens/1_patient_screens/tpn_screens/tpn_mixing/tpn_mixing_status_logic.dart';
import 'package:demo_app2/presentation/widgets/status/show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../../data/models/TPN/1_TPN_procedure.dart';
import '../../../../../data/models/medical/7_medical_procedure.dart';
import '../../../../widgets/nice_widgets/nice_export.dart';
import '../../../../widgets/status/loading_dialog.dart';
import '0.2_mixing_guide.dart';

class TPNMixingWidget extends StatelessWidget {
  final TPNProcedureOnlineCubit tpnProcedureOnlineCubit;
  const TPNMixingWidget({Key? key, required this.tpnProcedureOnlineCubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleContainer(
      child: BlocBuilder(
          bloc: tpnProcedureOnlineCubit,
          builder: (ct, st) {
            final MedicalProcedure procedure = tpnProcedureOnlineCubit.state;
            final logic = TPNMixingStatusLogic(procedure: procedure);
            final RegimenStatus status = logic.status;
            // if (status == RegimenStatus.done &&
            //     MixingRange().rangeContainToday(DateTime.now()) == null) {
            //   return Text(MixingRange().waitingMessage(DateTime.now()));
            // }
            switch (status) {
              case RegimenStatus.guideMixing:
                return MixingGuideWidget(
                    tpnProcedureOnlineCubit: tpnProcedureOnlineCubit);
              case RegimenStatus.done:
                {
                  if (logic.stillMixing)
                    return Text(MedicalMixing.doingLine);
                  else
                    return Column(
                      children: [
                        Text('Đã truyền xong.'),
                        Text(MixingRange().waitingMessage(DateTime.now())),
                      ],
                    );
                }
              default:
                return Text('Chưa biết');
            }
          }),
    );
  }
}
