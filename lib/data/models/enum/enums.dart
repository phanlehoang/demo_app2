export '1_enum_to_string.dart';
export '3_enum_to_name.dart';
export '2_string_to_enum.dart';
export '4_medical_action_to_name.dart';

enum Gender {
  Male,
  Female,
}

enum ProcedureType {
  TPN,
  Sonde,
  Unknown,
}

enum ProcedureStatus {
  firstAsk,
  noInsulin,
  yesInsulin,
  highInsulin,
  finish,
}

enum RegimenStatus {
  error,
  checkingGlucose,
  givingInsulin,
  done,
}

enum InsulinType {
  Glargine,
  Actrapid,
  NPH,
  Lantus,
  Unknown,
}
