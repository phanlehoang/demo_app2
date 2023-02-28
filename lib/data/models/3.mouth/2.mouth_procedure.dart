// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:demo_app2/data/models/enum/enums.dart';

import '1.mouth_regimen.dart';

class MouthProcedure {
  String name = 'MouthProcedure';
  List<MouthRegimen> regimens;
  DateTime beginTime;
  num weight;
  MouthProcedureStatus status;
  MouthProcedure({
    required this.name,
    required this.regimens,
    required this.beginTime,
    required this.weight,
    required this.status,
  });
  DateTime get lastTime {
    if (regimens.length == 0) {
      return beginTime;
    }
    return regimens.last.lastTime;
  }

  bool get isFull50 {
    if (regimens.length == 0) {
      return false;
    }
    return regimens.last.isFull50;
  }

  //toString
  @override
  String toString() {
    return 'MouthProcedure{name: $name, regimens: $regimens, beginTime: $beginTime, weight: $weight, status: $status}';
  }

  Map<String, dynamic> get toDataMap {
    final map1 = {
      'name': name,
      'beginTime': beginTime,
      'weight': weight,
      'status': EnumToString.enumToString(status),
    };
    return map1;
  }
}
