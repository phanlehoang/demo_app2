//profile cubit

import 'package:demo_app2/data/models/2.1_profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data_provider/patient_provider.dart';
import '2_profile.dart';

class CurrentProfileCubit extends ProfileCubit {
  CurrentProfileCubit() : super(unknownProfile());
  //choose profile
  Future<void> choose(Profile profile)  async {
    emit(profile);
  }
}
