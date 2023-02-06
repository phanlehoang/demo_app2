import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class CurrentGroupIdCubit extends Cubit<String> with HydratedMixin {
  CurrentGroupIdCubit() : super('Unknown');
  void update(String group) {
    emit(group);
  }

  //close
  @override
  Future<void> close() {
    return super.close();
  }

  @override
  String? fromJson(Map<String, dynamic> json) {
    return json['currentGroupId'] as String;
  }

  @override
  Map<String, dynamic>? toJson(String state) {
    return {'currentGroupId': state};
  }
}
