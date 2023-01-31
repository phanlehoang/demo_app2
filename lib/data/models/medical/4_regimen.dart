// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:demo_app2/data/models/enum/enums.dart';
import 'package:equatable/equatable.dart';

import '../time_controller/sonde_range.dart';
import '2.5_list_medical_from_list_map.dart';
import '2_medical_check_glucose.dart';
import '3_medical_take_insulin.dart';

class Regimen extends Equatable{
  //1. attributes
  String name;
  List<dynamic> medicalActions;
  DateTime beginTime;
  Regimen({
    required this.name,
    required this.medicalActions,
    required this.beginTime,
  });
  //1.1. compare
  //props
  @override
  List<Object?> get props => [name, medicalActions];
  //2. methods add
  void addMedicalAction(dynamic medicalAction) {
    medicalActions.add(medicalAction.clone());
  }
  //3. print for debug
  @override
  String toString() {
    dynamic medicalActions_str = medicalActions.toString();
    return '''Regimen name: $name, 
              beginTime: $beginTime,
               ${medicalActions_str}
    ''';
  }
  //4. convert data
  //toMap

  Map<String, dynamic> toMap() {
    return {
      'medicalActions': [for (dynamic x in medicalActions) x.toMap()],
      'name': name,
      'beginTime': beginTime,
    };
  }

  //fromMap
  factory Regimen.fromMap(Map<String, dynamic>? map) {
    if (map == null) return errorRegimen();
    return Regimen(
      medicalActions:
          ListMedicalFromListMap.medicalActions(map['medicalActions']), 
      name: map['name']!=null?map['name']:'Unknown',
       beginTime: map['beginTime']!=null?map['beginTime'].toDate():DateTime.now(),
    );
  }
  //from snapshot
  factory Regimen.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    return Regimen.fromMap(map);
  }
  Regimen clone() {
    return Regimen(
      medicalActions: [for (dynamic x in medicalActions) x.clone()],
      name: name,
      beginTime: beginTime,
      );
  }
    //6. get data  
   List<MedicalCheckGlucose> get medicalCheckGlucoses {
    List<MedicalCheckGlucose> list = [];
    for (var x in medicalActions) {
      if (x is MedicalCheckGlucose) list.add(x);
    }
    return list;
  }
  List<MedicalTakeInsulin> get medicalTakeInsulins{
    List<MedicalTakeInsulin> list = [];
    for (var x in medicalActions) {
      if (x is MedicalTakeInsulin) list.add(x);
    }
    return list;
  }
  //medical take actrapid insulin
  List<MedicalTakeInsulin> get medicalTakeActrapidInsulins{
    List<MedicalTakeInsulin> list = [];
    for (var x in medicalActions) {
      if (x is MedicalTakeInsulin && x.insulinType == InsulinType.Actrapid) list.add(x);
    }
    return list;
  }
  //medical take not actrapid insulin
  List<MedicalTakeInsulin> get medicalTakeNotActrapidInsulins{
    List<MedicalTakeInsulin> list = [];
    for (var x in medicalActions) {
      if (x is MedicalTakeInsulin && x.insulinType != InsulinType.Actrapid) list.add(x);
    }
    return list;
  }
  //get last 
  num get lastGluAmount {
    if (medicalCheckGlucoses.length == 0) return 0;
    return medicalCheckGlucoses.last.glucoseUI;
  }
  DateTime get lastGluTime{
    if (medicalCheckGlucoses.length == 0) return DateTime(1999);
    return medicalCheckGlucoses.last.time;
  }
  //get last actrapid insulin
  DateTime get lastActrapidInsulinTime {
    if (medicalTakeActrapidInsulins.length == 0) return DateTime(1999); 
    return medicalTakeActrapidInsulins.last.time;
  }
  //get last not actrapid insulin
  DateTime get lastNotActrapidInsulinTime {
    if (medicalTakeNotActrapidInsulins.length == 0) return DateTime(1999); 
    return medicalTakeNotActrapidInsulins.last.time;
  }
  RegimenStatus get slowStatus{
    if(!SondeRange.isHot(lastNotActrapidInsulinTime)) 
      return RegimenStatus.givingInsulin;
    return RegimenStatus.done;
  }
  RegimenStatus get fastStatus{
    if(!SondeRange.isHot(lastGluTime)) return RegimenStatus.checkingGlucose;
    if(!SondeRange.isHot(lastActrapidInsulinTime)) 
      return RegimenStatus.givingInsulin;
    return RegimenStatus.done;
  }
  bool get isFull50 {
    int counter = 0;
    for (var x in medicalCheckGlucoses) {
      if (x.glucoseUI > 8.3) counter++;
    }
    return counter >= 1;
  }

  DateTime get lastTime{
    if (medicalActions.length == 0) return beginTime;
    return medicalActions.last.time;
  }

  DateTime get firstTime{
    return beginTime;
  }

 
}

Regimen initialRegimen() {
  return Regimen(
    beginTime: DateTime.now(),
    medicalActions: [], name: 'Unknown',
  );
}

Regimen errorRegimen(){
  return Regimen(
    beginTime: DateTime.now(),
    medicalActions: [], name: 'Error',
  );
}
// class RegimenSondeFast extends Regimen {
//   num cho;
//   String name;
//   RegimenSondeFast({
//     required List<dynamic> medicalActions,
//     required List<MedicalCheckGlucose> medicalCheckGlucoses,
//     required List<MedicalTakeInsulin> medicalTakeInsulins,
//     required this.cho,
//     required this.name,
//   }) : super(
//           medicalActions: medicalActions,
//           medicalCheckGlucoses: medicalCheckGlucoses,
//           medicalTakeInsulins: medicalTakeInsulins,
//         );
//   //override  toString
//   @override
//   String toString() {
//     dynamic medicalActions_str = medicalActions.toString();
//     return 'Regimen ${medicalActions_str}\n cho: $cho \n name: $name';
//   }

//   //toMap
//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'cho': cho,
//       'medicalActions': [for (dynamic x in medicalActions) x.toMap()],
//       'medicalCheckGlucoses': [
//         for (MedicalCheckGlucose x in medicalCheckGlucoses) x.toMap()
//       ],
//       'medicalTakeInsulins': [
//         for (MedicalTakeInsulin x in medicalTakeInsulins) x.toMap()
//       ],
//     };
//   }

//   //fromMap
//   factory RegimenSondeFast.fromMap(Map<String, dynamic> map) {
//     return RegimenSondeFast(
//       name: map['name'],
//       cho: map['cho'],
//       medicalActions:
//           ListMedicalFromListMap.medicalActions(map['medicalActions']),
//       medicalCheckGlucoses: ListMedicalFromListMap.medicalCheckGlucoses(
//           map['medicalCheckGlucoses']),
//       medicalTakeInsulins: ListMedicalFromListMap.medicalTakeInsulins(
//           map['medicalTakeInsulins']),
//     );
//   }
//   //from Regimen and cho
//   factory RegimenSondeFast.fromRegimenAndCho(
//     Regimen regimen,
//     num cho,
//     String name,
//   ) {
//     return RegimenSondeFast(
//       cho: cho,
//       medicalActions: regimen.medicalActions,
//       medicalCheckGlucoses: regimen.medicalCheckGlucoses,
//       medicalTakeInsulins: regimen.medicalTakeInsulins,
//       name: name,
//     );
//   }
// }
