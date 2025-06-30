part of 'calculator_bloc.dart';

class CalculatorState {
  final String expression;
  final String result;

  CalculatorState({required this.expression, required this.result});

  CalculatorState copyWith({String? expression, String? result}) {
    return CalculatorState(
      expression: expression ?? this.expression,
      result: result ?? this.result,
    );
  }
}
