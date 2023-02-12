import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/data/models/doctor/current_doctor.dart';
import 'package:demo_app2/data/models/enum/enums.dart';
import 'package:demo_app2/data/models/medical/4_regimen.dart';
import 'package:demo_app2/data/models/sonde/sonde_lib.dart';
import 'package:demo_app2/presentation/screens/2_doctor_screens/candies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../authentication/login_screen/1_login_screen.dart';
import '../../../data/data_provider/regimen_provider.dart';
import '../../../data/models/doctor/doctor.dart';
import '../../../data/models/medical/2_medical_check_glucose.dart';
import '../../../data/models/medical/3_medical_take_insulin.dart';
import '../../widgets/bars/bottom_navitgator_bar.dart';
import '../../widgets/bars/doctor_navigator_bar.dart';
import '../3_setting_screens/remember_login_cubit.dart';
import 'cubit/counter_cubit.dart';
import 'cubit/counter_state.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic trial;
    Regimen myReg = initialRegimen();

    final CurrentDoctorCubit currentDoctorCubit = CurrentDoctorCubit(
      rememberLoginCubit: context.read<RememberLoginCubit>(),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Hồ sơ bác sĩ"),
        //  flexibleSpace: DoctorNavigatorBar(),
      ),
      body: SingleChildScrollView(
          child: Column(
        //button
        children: [
          DoctorInformation(currentDoctorCubit: currentDoctorCubit),
          BlocBuilder(
            bloc: context.read<RememberLoginCubit>(),
            builder: (context, st) {
              final state = st as String;
              final RememberLoginCubit rememberLoginCubit =
                  context.read<RememberLoginCubit>();
              final oldContext = context;
              return Column(
                children: [
                  Center(
                      child: Text(
                    'email:   ' + state.toString(),
                    style: TextStyle(fontSize: 15),
                  )),
                  // edit profile button

                  SizedBox(
                    height: 50,
                  ),
                  // sign out button
                  ElevatedButton(
                    onPressed: () {
                      rememberLoginCubit.signOut();
                      Navigator.pushReplacement(
                        oldContext,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    // edit button style
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    // thêm icon logout
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.logout),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Đăng xuất'),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      )
          //  if(state.length == 0) return Text('Chua co du lieu');

          ),
      bottomNavigationBar: BottomNavigatorBar(),
    );
  }
}

class DoctorInformation extends StatelessWidget {
  final CurrentDoctorCubit currentDoctorCubit;
  const DoctorInformation({
    super.key,
    required this.currentDoctorCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            'Thông tin bác sĩ',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
        BlocBuilder(
          bloc: currentDoctorCubit,
          builder: (context, st) {
            final state = st as Doctor;
            return Column();
          },
        ),
      ],
    );
  }
}
