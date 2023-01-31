import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/2_profile.dart';

class PatientCreate {
  //create a group in firebase
  static Future<void> createPatient(Map<String, dynamic> map) async {
    var db = FirebaseFirestore.instance;
    var ref = await db
        .collection('groups')
        .doc(map['room'])
        .collection('patients')
        .doc(map['id'])
   .set({'profile': map});
    }
}

class PatientRead {
  //get patient profile
  static Future<Profile?> getPatient(String room, String id) async {
    var db = FirebaseFirestore.instance;
    var ref = db.collection('groups').doc(room).collection('patients').doc(id);
    try {
      print('try');
      var rawData = await ref.get();
      var profile = rawData['profile'];
      print('profile $profile');
      var model = Profile.fromMap(profile);
      print('model $model');
      return model;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
class PatientRef{
  static DocumentReference getPatientRef(Profile profile){
    var db = FirebaseFirestore.instance;
    var ref = db.collection('groups')
    .doc(profile.room).collection('patients').doc(profile.id);
    return ref;
  }
}

class PatientUpdate {
  //updaate patient profile
  static Future<String?> updateProfileAttribute({
    required Profile profile,
    required String attribute,
    dynamic value,
  }) async {
    var db = FirebaseFirestore.instance;
    var ref = db
        .collection('groups')
        .doc(profile.room)
        .collection('patients')
        .doc(profile.id);
    try {
      var ans = ref.update({'profile.${attribute}': value});
      return null;
    } catch (e) {
      print(e);
    }

    return 'Error updating patient';
  }
}
