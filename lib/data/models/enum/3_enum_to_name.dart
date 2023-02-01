import 'enums.dart';

class EnumToName {
  //SondeStatus to name
  static String sondeStatusToName(ProcedureStatus status) {
    switch (status) {
      case ProcedureStatus.firstAsk:
        return 'Hỏi';
      case ProcedureStatus.noInsulin:
        return 'Phác đồ không tiêm ';
      
      case ProcedureStatus.yesInsulin:
        return 'Phác đồ có tiêm';
    
      case ProcedureStatus.highInsulin:
        return 'Phác đồ liều cao';
    
      case ProcedureStatus.finish:
        return 'Kết thúc';
      default:
        return 'Đang chờ';
    }
  }
}
