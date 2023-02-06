// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CounterState extends Equatable {
  int counterValue;
  bool wasIncremented;
  //init
  CounterState({
    required this.counterValue,
    required this.wasIncremented,
  });

  @override
  List<Object> get props => [
        counterValue,
        wasIncremented,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'counterValue': counterValue,
      'wasIncremented': wasIncremented,
    };
  }

  factory CounterState.fromMap(Map<String, dynamic>? map) {
    if (map == null) return CounterInitial();
    return CounterState(
      counterValue: map['counterValue'] as int,
      wasIncremented: map['wasIncremented'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory CounterState.fromJson(String source) =>
      CounterState.fromMap(json.decode(source) as Map<String, dynamic>);
}

class CounterInitial extends CounterState {
  CounterInitial() : super(counterValue: 0, wasIncremented: true);
}
