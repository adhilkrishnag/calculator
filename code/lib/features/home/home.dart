import 'package:calculator/logic/blocs/calculator_bloc/calculator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final buttons = [
      'C',
      'DEL',
      '/',
      '*',
      '7',
      '8',
      '9',
      '-',
      '4',
      '5',
      '6',
      '+',
      '1',
      '2',
      '3',
      '=',
      '0',
      '.',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Calculator')),
      body: Focus(
        focusNode: FocusNode()..requestFocus(),
        onKeyEvent: (FocusNode node, KeyEvent event) {
          if (event is KeyDownEvent) {
            // Only handle key down to prevent duplicates
            _handleKeyPress(context, event);
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        },
        child: Column(
          children: [
            // Display area
            Container(
              height: MediaQuery.sizeOf(context).height * 0.25,
              width: double.infinity,
              color: Colors.grey[200],
              padding: const EdgeInsets.all(16),
              child: BlocBuilder<CalculatorBloc, CalculatorState>(
                builder: (context, state) => Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      state.expression.isEmpty ? '0' : state.expression,
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.result,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Button grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                childAspectRatio: 1,
                padding: const EdgeInsets.all(8),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: buttons.asMap().entries.map((entry) {
                  final value = entry.value;
                  return ElevatedButton(
                    onPressed: () {
                      if (value == 'C') {
                        context.read<CalculatorBloc>().add(Clear());
                      } else if (value == 'DEL') {
                        context.read<CalculatorBloc>().add(Delete());
                      } else if (value == '=') {
                        context.read<CalculatorBloc>().add(Calculate());
                      } else {
                        context.read<CalculatorBloc>().add(AddInput(value));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _getButtonColor(value),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(value, style: const TextStyle(fontSize: 24)),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleKeyPress(BuildContext context, KeyEvent event) {
    final key = event.logicalKey;

    // Number keys (regular and numpad)
    if (key == LogicalKeyboardKey.digit0 || key == LogicalKeyboardKey.numpad0) {
      context.read<CalculatorBloc>().add(AddInput('0'));
    } else if (key == LogicalKeyboardKey.digit1 ||
        key == LogicalKeyboardKey.numpad1) {
      context.read<CalculatorBloc>().add(AddInput('1'));
    } else if (key == LogicalKeyboardKey.digit2 ||
        key == LogicalKeyboardKey.numpad2) {
      context.read<CalculatorBloc>().add(AddInput('2'));
    } else if (key == LogicalKeyboardKey.digit3 ||
        key == LogicalKeyboardKey.numpad3) {
      context.read<CalculatorBloc>().add(AddInput('3'));
    } else if (key == LogicalKeyboardKey.digit4 ||
        key == LogicalKeyboardKey.numpad4) {
      context.read<CalculatorBloc>().add(AddInput('4'));
    } else if (key == LogicalKeyboardKey.digit5 ||
        key == LogicalKeyboardKey.numpad5) {
      context.read<CalculatorBloc>().add(AddInput('5'));
    } else if (key == LogicalKeyboardKey.digit6 ||
        key == LogicalKeyboardKey.numpad6) {
      context.read<CalculatorBloc>().add(AddInput('6'));
    } else if (key == LogicalKeyboardKey.digit7 ||
        key == LogicalKeyboardKey.numpad7) {
      context.read<CalculatorBloc>().add(AddInput('7'));
    } else if (key == LogicalKeyboardKey.digit8 ||
        key == LogicalKeyboardKey.numpad8) {
      context.read<CalculatorBloc>().add(AddInput('8'));
    } else if (key == LogicalKeyboardKey.digit9 ||
        key == LogicalKeyboardKey.numpad9) {
      context.read<CalculatorBloc>().add(AddInput('9'));
    } else if (key == LogicalKeyboardKey.period ||
        key == LogicalKeyboardKey.numpadDecimal) {
      context.read<CalculatorBloc>().add(AddInput('.'));
    } else if (key == LogicalKeyboardKey.add ||
        key == LogicalKeyboardKey.numpadAdd) {
      context.read<CalculatorBloc>().add(AddInput('+'));
    } else if (key == LogicalKeyboardKey.minus ||
        key == LogicalKeyboardKey.numpadSubtract) {
      context.read<CalculatorBloc>().add(AddInput('-'));
    } else if (key == LogicalKeyboardKey.asterisk ||
        key == LogicalKeyboardKey.numpadMultiply) {
      context.read<CalculatorBloc>().add(AddInput('*'));
    } else if (key == LogicalKeyboardKey.slash ||
        key == LogicalKeyboardKey.numpadDivide) {
      context.read<CalculatorBloc>().add(AddInput('/'));
    } else if (key == LogicalKeyboardKey.enter ||
        key == LogicalKeyboardKey.numpadEnter) {
      context.read<CalculatorBloc>().add(Calculate());
    } else if (key == LogicalKeyboardKey.backspace) {
      context.read<CalculatorBloc>().add(Delete());
    } else if (key == LogicalKeyboardKey.escape) {
      context.read<CalculatorBloc>().add(Clear());
    }
  }

  Color _getButtonColor(String value) {
    if (['C', 'DEL'].contains(value)) {
      return Colors.red[300]!;
    } else if (['/', '*', '-', '+', '='].contains(value)) {
      return Colors.blue[300]!;
    } else {
      return Colors.grey[300]!;
    }
  }
}
