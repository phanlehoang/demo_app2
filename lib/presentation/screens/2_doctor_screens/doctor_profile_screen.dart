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

import '../../../data/data_provider/regimen_provider.dart';
import '../../../data/models/medical/2_medical_check_glucose.dart';
import '../../../data/models/medical/3_medical_take_insulin.dart';
import '../../widgets/bars/bottom_navitgator_bar.dart';
import '../../widgets/bars/doctor_navigator_bar.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic trial;
    Regimen myReg = initialRegimen();



    return Scaffold(
      appBar: AppBar(
        title: Text("Hồ sơ bác sĩ"),
        //  flexibleSpace: DoctorNavigatorBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          //button
          children: [
             BlocBuilder(
              bloc: context.read<CurrentDoctor>(),
              builder: (context, st) {
                final state = context.read<CurrentDoctor>().state;
               return Text(state.email.toString());
              },
             )
          ],
        )
      //  if(state.length == 0) return Text('Chua co du lieu');

       
      ),
      bottomNavigationBar: BottomNavigatorBar(),
    );
  }
}

Regimen testReg() {
  MedicalTakeInsulin m = MedicalTakeInsulin(
    time: DateTime(1999),
    insulinType: InsulinType.Actrapid,
    insulinUI: 100,
  );
  //Medical check glu
  MedicalCheckGlucose m2 = MedicalCheckGlucose(
    time: DateTime(1999),
    glucoseUI: 100,
  );
  Regimen r = Regimen(
    medicalActions: [m, m2],
    name: 'Regimen 1', beginTime: DateTime.now(),
  );
  return r;
}
