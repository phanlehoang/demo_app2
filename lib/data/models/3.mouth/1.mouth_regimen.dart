// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../medical/4_regimen.dart';

class MouthRegimen extends Regimen {
  List<String> healthConditions;
  MouthRegimen({
    required DateTime beginTime,
    required String name,
    required List<String> medicalActions,
    required this.healthConditions,
  }) : super(
          beginTime: beginTime,
          name: name,
          medicalActions: medicalActions,
        );
  factory MouthRegimen.fromMap(Map<String, dynamic> map) {
    return MouthRegimen(
      beginTime: map['beginTime'].toDate(),
      name: map['name'],
      medicalActions: List<String>.from(map['medicalActions']),
      healthConditions: List<String>.from(map['healthConditions']),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'beginTime': beginTime,
      'name': name,
      'medicalActions': medicalActions,
      'healthConditions': healthConditions,
    };
  }
}
