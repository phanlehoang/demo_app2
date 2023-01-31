

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/data/data_provider/patient_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '2_profile.dart';

class ProfileCubit extends Cubit<Profile> {
  ProfileCubit(Profile profile) : super(profile);

  //ref 
  DocumentReference  patientRef() => PatientRef.getPatientRef(state);

  // from firestore
  Future<void> reload() async {
    var snapshot = await patientRef().get();
    //if snapshot exists
    var data= snapshot.data() as Map<String, dynamic>;
    if (data['profile'] != null)
      emit(Profile.fromMap(data['profile']));
    }


  Future<void> create(Profile profile) async {
    var update = await patientRef().set({'profile': profile.toMap()});
    await reload();
  }
  //read profile 
  Future<void> read() async {
    var snapshot = await patientRef().get();
    //if snapshot exists
    if (snapshot.exists)
    emit(Profile.fromMap(snapshot.data() as Map<String, dynamic>));
  }
  //update profile 
  Future<void> update( String attribute, dynamic value) async {
    var update = await patientRef().update({'profile.$attribute': value});
  var reload2 =  await reload();
  }

}