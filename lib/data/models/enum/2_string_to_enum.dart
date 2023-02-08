import 'enums.dart';

class StringToEnum {
  //gender
  static Gender stringToGender(String g) {
    switch (g) {
      case 'Nam':
        return Gender.Male;
      default:
        return Gender.Female;
    }
  }

  //procedureType
  static ProcedureType stringToProcedureType(String m) {
    switch (m) {
      case 'TPN':
        return ProcedureType.TPN;
      case 'Sonde':
        return ProcedureType.Sonde;
      default:
        return ProcedureType.Unknown;
    }
  }

  //sondeStatus
  static ProcedureStatus stringToSondeStatus(String s) {
    switch (s) {
      case 'firstAsk':
        return ProcedureStatus.firstAsk;
      case 'noInsulin':
        return ProcedureStatus.noInsulin;

      case 'yesInsulin':
        return ProcedureStatus.yesInsulin;

      case 'highInsulin':
        return ProcedureStatus.highInsulin;
      case 'finish':
        return ProcedureStatus.finish;

      default:
        return ProcedureStatus.firstAsk;
    }
  }

  //insulinType
  static InsulinType stringToInsulinType(String i) {
    switch (i) {
      case 'Glargine':
        return InsulinType.Glargine;
      case 'Actrapid':
        return InsulinType.Actrapid;
      case 'NPH':
        return InsulinType.NPH;
      case 'Lantus':
        return InsulinType.Lantus;
      case 'Unknown':
        return InsulinType.Unknown;
      default:
        return InsulinType.Actrapid;
    }
  }
}
