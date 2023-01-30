

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/data/models/models_export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../enum/enums.dart';
import '../medical/4_regimen.dart';
import '6_sonde_state.dart';
import '7_sonde_procedure.dart';

class SondeProcedureCubit extends Cubit<SondeProcedure>{
   final Profile profile;
   DateTime beginTime;
    SondeProcedureCubit({required this.profile,
    required this.beginTime,
    }) : super(SondeProcedure(
    beginTime: beginTime,
    state: SondeState(
      status: SondeStatus.firstAsk,
    ),
    regimens: [],
  ));
  DocumentReference sondeRef(){
    return FirebaseFirestore.instance.collection('groups')
    .doc(profile.room).collection('patients'). 
    doc(profile.id).collection('procedures').doc(beginTime.toString());
  }
  Future<DocumentReference?> lastRegimenRef() async {
    CollectionReference regimensRef = sondeRef().collection('regimens');
    List<QueryDocumentSnapshot> docs = (await regimensRef.get()).docs;
    if (docs.isEmpty) {
      return null;
    }
    return regimensRef.doc(docs.last.id);
  }
  //create 
  Future<void> createSonde() async {
    await sondeRef().set({
      
    });
  }
  Future<String?> addRegimen(Regimen regimen) async {
    CollectionReference regimensRef = sondeRef().collection('regimens');
    try {
      await regimensRef.doc(regimen.beginTime.toString()).set(regimen.toMap());
    } catch (e) {
      return e.toString();
    }
  }
  Future<void> addMedicalAction(dynamic medicalAction) async {
    
    DocumentReference? lastRegimen = await lastRegimenRef();
    if (lastRegimen == null) {
       //error
       throw Exception('lastRegimen is null');
    }
    var update = await lastRegimen.update({
      'medicalActions': FieldValue.arrayUnion([medicalAction.toMap()])
    });
  }
}