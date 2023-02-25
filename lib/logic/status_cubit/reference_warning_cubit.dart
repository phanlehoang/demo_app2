

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ReferenceWarningCubit extends Cubit<bool> with HydratedMixin{
  ReferenceWarningCubit() : super(true);

  void updateWarning(bool? value) {
    if(value==null) return;
    emit(value);
  }

  void showWarning() {
    emit(true);
  }

  void hideWarning() {
    emit(false);
  }
  
  @override
  bool fromJson(Map<String, dynamic> json) {
    return json['showWarning'] as bool? ?? true;
  }
  
  @override
  Map<String, dynamic>? toJson(bool state) {
    return {'showWarning': state};
  }
}