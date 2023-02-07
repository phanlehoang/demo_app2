import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> with HydratedMixin {
  CounterCubit() : super(CounterInitial());
  //increment
  void increment() {
    emit(CounterState(
      counterValue: state.counterValue + 1,
      wasIncremented: true,
    ));
  }

  //decrement
  void decrement() {
    emit(CounterState(
      counterValue: state.counterValue - 1,
      wasIncremented: false,
    ));
  }

  @override
  CounterState? fromJson(Map<String, dynamic> json) {
    return CounterState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(CounterState state) {
    return state.toMap();
  }
}
