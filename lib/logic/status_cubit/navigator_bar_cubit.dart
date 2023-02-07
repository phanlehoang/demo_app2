import 'package:hydrated_bloc/hydrated_bloc.dart';

class IndexCubit extends Cubit<int> {
  IndexCubit() : super(0);
  Future<void> update(int index) async => emit(index);
}

class BottomNavigatorBarCubit extends IndexCubit {}

class PatientNavigatorBarCubit extends IndexCubit {}

class DoctorNavigatorBarCubit extends IndexCubit {}
