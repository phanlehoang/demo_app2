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

  //mouthProcedureStatus
  static MouthProcedureStatus stringToMouthProcedureStatus(String s) {
    switch (s) {
      case 'loading':
        return MouthProcedureStatus.loading;
      case 'firstAsk':
        return MouthProcedureStatus.firstAsk;
      case 'acuteHyperglycemia':
        return MouthProcedureStatus.acuteHyperglycemia;
      case 'secondAsk':
        return MouthProcedureStatus.secondAsk;
      case 'hypoglycemia':
        return MouthProcedureStatus.hypoglycemia;
      case 'baseBolus':
        return MouthProcedureStatus.baseBolus;
      case 'endocrineConference':
        return MouthProcedureStatus.endocrineConference;
      case 'finish':
        return MouthProcedureStatus.finish;
      default:
        return MouthProcedureStatus.firstAsk;
    }
  }
}
