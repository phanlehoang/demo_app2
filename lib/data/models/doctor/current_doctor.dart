

import 'package:demo_app2/data/models/doctor/doctor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentDoctor extends Cubit<Doctor> {
  CurrentDoctor() : super(Doctor());

  void updateEmail(String email) async{
    
    emit(Doctor(email: email));
  }
}