//tạo ra màn hình login trial với material

import 'package:demo_app2/authentication/decoration/0_diagonal_streak_decoration_screen.dart';
import 'package:demo_app2/authentication/decoration/2_doctor_image_login.dart';
import 'package:demo_app2/authentication/decoration/welcome_back_widget.dart';
import 'package:demo_app2/data/models/doctor/current_doctor.dart';
import 'package:demo_app2/data/models/doctor/doctor.dart';
import 'package:demo_app2/logic/global/current_export.dart';
import 'package:demo_app2/presentation/widgets/status/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../presentation/widgets/status/show_toast.dart';
import '2.login_form.dart';
import '5_button_to_forget_password.dart';
import '4_button_to_sign_up.dart';
import '2.1.login_form_bloc.dart';
import '3.nice_login_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DiagonalStreakDecorationScreen(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            DoctorImageLogin(),
            WelcomeBackWidget(),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}
