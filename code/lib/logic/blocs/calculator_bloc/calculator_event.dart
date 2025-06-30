part of 'calculator_bloc.dart';

abstract class CalculatorEvent {}

class AddInput extends CalculatorEvent {
  final String input;
  AddInput(this.input);
}

class Clear extends CalculatorEvent {}

class Delete extends CalculatorEvent {}

class Calculate extends CalculatorEvent {}
