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
import '../decoration/2.1_doctor_image_sign_up.dart';
import '2_sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng kí'),
      ),
      body: Center(
        child: DiagonalStreakDecorationScreen(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              DoctorImageSignUp(),
              SignUpForm(),
            ],
          ),
        ),
      ),
    );
  }
}
