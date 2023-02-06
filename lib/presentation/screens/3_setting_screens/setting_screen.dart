import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/authentication/login_screen/1_login_screen.dart';
import 'package:demo_app2/presentation/screens/3_setting_screens/my_home_page.dart';
import 'package:demo_app2/presentation/screens/3_setting_screens/remember_login_cubit.dart';
import 'package:demo_app2/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:demo_app2/presentation/widgets/status/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_notebook_background/responsive_notebook_background.dart';

import '../../../data/models/doctor/current_doctor.dart';
import '../../widgets/bars/bottom_navitgator_bar.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RememberLoginCubit rememberLoginCubit = RememberLoginCubit();
    return Scaffold(
      body: BlocBuilder(
        bloc: rememberLoginCubit,
        builder: (context, state) {
          final email = state as String;
          return LoginScreen();
        },
      ),
      // body: MyHomePage(
      //   keyCodeLocal: '',
      //   keyLocalLogin: '',
      //   title: '',
      // ),
      bottomNavigationBar: BottomNavigatorBar(),
    );
  }
}
