import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/data/models/models_export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../enum/enums.dart';
import '4_regimen.dart';
import '6_procedure_state.dart';
import '7_medical_procedure.dart';
import '../sonde/7_sonde_procedure.dart';

class MedicalProcedureCubit extends Cubit<MedicalProcedure> {
  final Profile profile;
  String procedureId;
  MedicalProcedureCubit({
    required this.profile,
    required this.procedureId,
  }) : super(SondeProcedure(
          beginTime: DateTime.tryParse(procedureId) != null
              ? DateTime.parse(procedureId)
              : DateTime.now(),
          state: ProcedureState(
            status: ProcedureStatus.firstAsk,
          ),
          regimens: [],
        ));
  DocumentReference get procedureRef {
    return FirebaseFirestore.instance
        .collection('groups')
        .doc(profile.room)
        .collection('patients')
        .doc(profile.id)
        .collection('procedures')
        .doc(procedureId);
  }

  //update SondeState
  Future<void> updateProcedureStateStatus(ProcedureState procedureState) async {
    //add regimens
    //slow insulin type
    InsulinType slowInsulinType = procedureState.slowInsulinType;
    switch (procedureState.status) {
      case ProcedureStatus.noInsulin:
        await addRegimen(Regimen(
          beginTime: DateTime.now(),
          medicalActions: [],
          name: 'Phác đồ dành cho BN không có tiền sử tiêm insulin',
        ));
        break;
      case ProcedureStatus.yesInsulin:
        await addRegimen(Regimen(
          beginTime: DateTime.now(),
          medicalActions: [],
          name: 'Phác đồ dành cho BN có tiền sử tiêm insulin',
        ));
        break;
      case ProcedureStatus.highInsulin:
        await addRegimen(Regimen(
          beginTime: DateTime.now(),
          medicalActions: [],
          name: 'Phác đồ tiêm insulin ở liều cao',
        ));
        break;
      default:
    }
    var up1 = await procedureRef.update(procedureState.toMap());
  }

  Future<DocumentReference?> lastRegimenRef() async {
    CollectionReference regimensRef = procedureRef.collection('regimens');
    List<QueryDocumentSnapshot> docs = (await regimensRef.get()).docs;
    if (docs.isEmpty) {
      return null;
    }
    return regimensRef.doc(docs.last.id);
  }

  Future<void> addRegimen(Regimen regimen) async {
    CollectionReference regimensRef = procedureRef.collection('regimens');
    try {
      await regimensRef.doc(regimen.beginTime.toString()).set(regimen.toMap());
    } catch (e) {
      print(e);
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
    ProcedureState sondeState = state.state;
    ProcedureStatus nextStatus = ProcedureStatus.firstAsk;
    switch (sondeState.status) {
      case ProcedureStatus.firstAsk:
        nextStatus = ProcedureStatus.noInsulin;
        break;
      case ProcedureStatus.noInsulin:
        nextStatus = ProcedureStatus.yesInsulin;
        break;
      case ProcedureStatus.yesInsulin:
        nextStatus = ProcedureStatus.highInsulin;
        break;
      case ProcedureStatus.highInsulin:
        nextStatus = ProcedureStatus.finish;
        break;
      default:
    }
    await updateProcedureStateStatus(ProcedureState(
      status: nextStatus,
      cho: state.state.cho,
      bonusInsulin: state.state.bonusInsulin,
      weight: state.state.weight,
      slowInsulinType: state.state.slowInsulinType,
    ));
  }
}
