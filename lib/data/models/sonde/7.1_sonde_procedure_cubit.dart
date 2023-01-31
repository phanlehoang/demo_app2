

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/data/models/models_export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../enum/enums.dart';
import '../medical/4_regimen.dart';
import '6_sonde_state.dart';
import '7_sonde_procedure.dart';

class SondeProcedureCubit extends Cubit<SondeProcedure>{
   final Profile profile;
   String procedureId;
    SondeProcedureCubit({required this.profile,
    required this.procedureId,
    }) : super(
      SondeProcedure(
        beginTime: DateTime.tryParse(procedureId)!=null ? DateTime.parse(procedureId): DateTime.now(),
    state: SondeState(
      status: SondeStatus.firstAsk,
    ),
    regimens: [],
  ));
  DocumentReference sondeRef(){
    return FirebaseFirestore.instance.collection('groups')
    .doc(profile.room).collection('patients'). 
    doc(profile.id).collection('procedures').doc(procedureId);
  }
  //update SondeState 
  Future<void> updateSondeStateStatus(SondeState sondeState) async {
    //add regimens
    switch (sondeState.status) {
      case SondeStatus.noInsulin:
        addRegimen(Regimen(
          beginTime: DateTime.now(),
          medicalActions: [], 
          name: 'ko tiem',
        ));
        break;
      case SondeStatus.yesInsulin:
        addRegimen(Regimen(
          beginTime: DateTime.now(),
          medicalActions: [], 
          name: 'co tiem',
        ));
        break;
      case SondeStatus.highInsulin:
        addRegimen(Regimen(
          beginTime: DateTime.now(),
          medicalActions: [], 
          name: 'co tiem cao',
        ));
        break;
      default:
    }
    var up1 =  await sondeRef().update(
     sondeState.toMap()
    );
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
  //chuyen den SondeStatus tiep theo
  Future<void> goToNextStatus() async {
    SondeState sondeState = state.state;
    SondeStatus nextStatus = SondeStatus.firstAsk;
    switch (sondeState.status) {
      case SondeStatus.firstAsk:
        nextStatus = SondeStatus.noInsulin;
        break;
      case SondeStatus.noInsulin:
        nextStatus = SondeStatus.yesInsulin;
        break;
      case SondeStatus.yesInsulin:
        nextStatus= SondeStatus.highInsulin;
        break;
      case SondeStatus.highInsulin:
        nextStatus = SondeStatus.finish;
        break;
      default:
    }
    await updateSondeStateStatus(SondeState(
      status: nextStatus,
      cho: state.state.cho,
      bonusInsulin: state.state.bonusInsulin,
      weight: state.state.weight,
    ));
  }
}