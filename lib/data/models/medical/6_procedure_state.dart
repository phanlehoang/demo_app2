import '../enum/enums.dart';

class ProcedureState {
  final ProcedureStatus status;
  num cho;
  num bonusInsulin;
  num weight;
  InsulinType slowInsulinType;
  ProcedureState({
    required this.status,
    this.cho = 0,
    this.bonusInsulin = 0,
    this.weight = 0, 
    this. slowInsulinType = InsulinType.Unknown,
  });
  //clone
  ProcedureState clone() {
    return ProcedureState(
      status: status,
      cho: cho,
      bonusInsulin: bonusInsulin,
      weight: weight,
      slowInsulinType: slowInsulinType,
    );
  }

  //to String
  @override
  String toString() {
    return '''Procedure State(status: $status,
     cho: $cho, bonusInsulin: $bonusInsulin,
      weight: $weight,
      slowInsulinType: $slowInsulinType,
      )''';
  }

  //to Map
  Map<String, dynamic> toMap() {
    return {
      'status': EnumToString.enumToString(status),
      'cho': cho,
      'bonusInsulin': bonusInsulin,
      'weight': weight,
      'slowInsulinType': EnumToString.enumToString(slowInsulinType),
    };
  }

  //from Map
  factory ProcedureState.fromMap(Map<String, dynamic> map) {
    try {
      return ProcedureState(
        status: StringToEnum.stringToSondeStatus(map['status']),
        cho: map['cho'],
        bonusInsulin: map['bonusInsulin'],
        weight: map['weight'],
        slowInsulinType: StringToEnum.stringToInsulinType(map['slowInsulinType']),
      );
    } catch (e) {
      var a = initSondeState();
      return a;
    }
  }
}

ProcedureState initSondeState() {
  return ProcedureState(status: ProcedureStatus.firstAsk);
}
