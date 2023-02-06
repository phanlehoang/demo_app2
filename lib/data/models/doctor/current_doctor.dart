import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/data/models/doctor/doctor.dart';
import 'package:demo_app2/presentation/screens/3_setting_screens/remember_login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentDoctorCubit extends Cubit<Doctor> {
  final RememberLoginCubit rememberLoginCubit;
  late StreamSubscription? _subscription;
  CurrentDoctorCubit({
    required this.rememberLoginCubit,
  }) : super(unknownDoctor) {
    _subscription = rememberLoginCubit.stream.listen((email) async {
      updateEmail(email);
    });
  }

  void updateEmail(String email) async {
    var ref = FirebaseFirestore.instance.collection('doctors').doc(email);
    var doc = await ref.get();
    if (doc.exists) {
      emit(Doctor.fromMap(doc.data()!));
    } else {
      emit(unknownDoctor);
    }
  }
}
