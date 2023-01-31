import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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

            TextButton(
                onPressed: () async {

                  var trial = await FirebaseFirestore.instance
                      .collection('list_adds')
                      .doc('add')
                      .set(testReg().toMap());
                  var trial2 = await FirebaseFirestore.instance
                      .collection('list_adds')
                      .doc('add')
                      .get().then((value) => value.data());
                  myReg = Regimen.fromMap(trial2);
                },
                child: Text('${trial}')),
            BlocProvider<CandiesOnlineCubit>
            (create: (context) => CandiesOnlineCubit(),
            child: Column(
              children: [
                Text('debug 1'),
                CandiesOnlineScreen(),
              ],
            ),),
          
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigatorBar(),
    );
  }
}

class CandiesOnlineScreen extends StatelessWidget {
  const CandiesOnlineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CandiesOnlineCubit, List<Candy>>(
      builder: (context, state) {
        return Column(
          children: [
            Text(state.toString()),
            Text(state.length.toString()),
          ],
        );
      //  if(state.length == 0) return Text('Chua co du lieu');

       
      },
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
