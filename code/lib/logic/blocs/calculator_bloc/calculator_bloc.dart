import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_expressions/math_expressions.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(CalculatorState(expression: '', result: '0')) {
    on<AddInput>((event, emit) {
      // Basic validation to prevent consecutive operators
      final lastChar = state.expression.isNotEmpty
          ? state.expression[state.expression.length - 1]
          : '';
      final isOperator = ['+', '-', '*', '/'].contains(event.input);
      if (isOperator && ['+', '-', '*', '/'].contains(lastChar)) {
        return; // Prevent consecutive operators
      }
      emit(state.copyWith(expression: state.expression + event.input));
    });

    on<Clear>((event, emit) {
      emit(CalculatorState(expression: '', result: '0'));
    });

    on<Delete>((event, emit) {
      if (state.expression.isNotEmpty) {
        emit(
          state.copyWith(
            expression: state.expression.substring(
              0,
              state.expression.length - 1,
            ),
          ),
        );
      }
    });

    on<Calculate>((event, emit) {
      try {
        final parser = GrammarParser();
        final exp = parser.parse(state.expression);
        final result = exp.evaluate(EvaluationType.REAL, ContextModel());
        emit(state.copyWith(result: result.toString()));
      } catch (e) {
        emit(state.copyWith(result: 'Error'));
      }
    });
  }
}
