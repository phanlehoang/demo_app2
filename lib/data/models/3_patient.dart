import '2_profile.dart';

class Patient {
  final Profile profile;
  List<dynamic> procedures;
  String currentProcedureId;
  Patient({
    required this.profile,
    required this.procedures, 
    this.currentProcedureId = 'Unknown',
  });
}


