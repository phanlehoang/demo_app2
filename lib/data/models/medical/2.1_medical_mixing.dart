import '1_medical_action.dart';

class MedicalMixing extends MedicalAction {
  MedicalMixing({
    required super.time,
  });
  //props
  @override
  List<Object?> get props => [this.time];
  // @override
  @override
  String toString() {
    // TODO: implement toString
    return 'Truyền glucose 10% 500ml pha truyền 10UI Actrapid (100ml/h).';
  }

  static String get guideline {
    return 'Truyền glucose 10% 500ml pha truyền 10UI Actrapid (100ml/h).';
  }

  static String get doingLine {
    return 'Đang truyền glucose 10% 500ml pha truyền 10UI Actrapid (100ml/h).';
  }

  //toMap
  Map<String, dynamic> toMap() {
    return {
      'name': 'MedicalMixing',
      'time': time,
    };
  }

  //fromMap
  factory MedicalMixing.fromMap(Map<String, dynamic>? map) {
    try {
      if (map == null) return errorMedicalMixing;
      return MedicalMixing(
        time: map['time'].toDate(),
      );
    } catch (e) {
      return errorMedicalMixing;
    }
  }
}

//error Medical Mixing
MedicalMixing errorMedicalMixing = MedicalMixing(
  time: DateTime(1999),
);
