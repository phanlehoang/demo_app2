import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/data/models/doctor/doctor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentDoctor extends Cubit<Doctor> {
  CurrentDoctor() : super(unknownDoctor);

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
