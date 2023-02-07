import 'dart:async';

import 'package:demo_app2/data/models/doctor/current_doctor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class RememberLoginCubit extends Cubit<String> {
  late StreamSubscription _streamSubscription;
  //current user

  RememberLoginCubit() : super('Unknown') {
    _streamSubscription = FirebaseAuth.instance.authStateChanges().listen(
          (User? user) => emit(
            user?.email ?? 'Unknown',
          ),
        );
  }
  //sign out
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
