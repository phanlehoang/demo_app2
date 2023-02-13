import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../../data/models/medical/2.1_medical_mixing.dart';
import '../../../../widgets/nice_widgets/nice_export.dart';
import '../../../../widgets/status/loading_dialog.dart';
import '../../../../widgets/status/show_toast.dart';
import '0.1_tpn_mixing_form_bloc.dart';

class MixingGuideWidget extends StatelessWidget {
  const MixingGuideWidget({
    super.key,
    required this.tpnProcedureOnlineCubit,
  });

  final tpnProcedureOnlineCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TPNMixingFormBloc(tpnProcedureOnlineCubit: tpnProcedureOnlineCubit),
      child: Builder(
        builder: (context) {
          final formBloc = context.watch<TPNMixingFormBloc>();
          return FormBlocListener<TPNMixingFormBloc, String, String>(
            onFailure: (context, state) => showToast('Lỗi'),
            child: Column(
              children: [
                //  Text('MedicalMixing'),
                Text(MedicalMixing.guideline),
                NiceButton(
                  onTap: formBloc.submit,
                  text: 'Bắt đầu truyền',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
