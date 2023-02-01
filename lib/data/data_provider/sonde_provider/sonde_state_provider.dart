import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/data/models/enum/enums.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../models/2_profile.dart';
import '../../models/sonde/sonde_lib.dart';

class SondeStatusUpdate {
  static Future<String?> updateSondeStatus({
    required Profile profile,
    required ProcedureStatus sondeStatus,
  }) async {
    var sonde = FirebaseFirestore.instance
        .collection('groups')
        .doc(profile.room)
        .collection('patients')
        .doc(profile.id)
        .collection('procedureTypes')
        .doc('Sonde');
    await sonde.update({
      'status': EnumToString.enumToString(sondeStatus),
    }).catchError((error) {
      return error.toString();
    });
    //nếu error thì return String error
    return null;
  }
}

class SondeStateCreate {
  static Future<String?> createSondeState({
    required Profile profile,
    required ProcedureState sondeState,
  }) async {
    var sonde = FirebaseFirestore.instance
        .collection('groups')
        .doc(profile.room)
        .collection('patients')
        .doc(profile.id)
        .collection('procedureTypes')
        .doc('Sonde');
    await sonde.set({
      'status': EnumToString.enumToString(sondeState.status),
      'cho': sondeState.cho,
      'weight': sondeState.weight,
      'bonusInsulin': 0,
    }).catchError((error) {
      return error.toString();
    });
    //nếu error thì return String error
    return null;
  }
}

DocumentReference<Map<String, dynamic>> sondeReference(Profile profile) {
  return FirebaseFirestore.instance
      .collection('groups')
      .doc(profile.room)
      .collection('patients')
      .doc(profile.id)
      .collection('procedureTypes')
      .doc('Sonde');
}
