import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/authentication/login_screen/1_login_screen.dart';
import 'package:demo_app2/logic/status_cubit/navigator_bar_cubit.dart';
import 'package:demo_app2/presentation/screens/3_setting_screens/remember_login_cubit.dart';
import 'package:demo_app2/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:demo_app2/presentation/widgets/status/loading_dialog.dart';
import 'package:demo_app2/presentation/widgets/status/reference_warning_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
//import reference_warning_reference_form_bloc.dart
import '../../../logic/status_cubit/reference_warning_cubit.dart';
import '../../../data/models/doctor/current_doctor.dart';
import '../../widgets/bars/bottom_navitgator_bar.dart';
import '../../widgets/nice_widgets/1_nice_container.dart';

class WarningReferenceForm extends StatelessWidget {
  const WarningReferenceForm({super.key});

  @override
  Widget build(BuildContext context) {
    return NiceScreen(
      child: Column(
        children: [
          BlocBuilder(
            bloc: context.read<ReferenceWarningCubit>(),
            builder: (ct,st){
              return SimpleContainer
              (
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.7,
                      child: Text('Hiển thị cảnh báo: Các chỉ dẫn chỉ mang tính tham khảo')),
                    //thanh trượt
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.2,
                      child: Switch(
                        value: st as bool,
                        
                        onChanged: (value) {
                          context.read<ReferenceWarningCubit>().updateWarning(value);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ]
      ),
    );
  }
}
