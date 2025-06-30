import 'package:calculator/features/home/home.dart';
import 'package:calculator/logic/blocs/calculator_bloc/calculator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: BlocProvider(
        create: (context) => CalculatorBloc(),
        child: const Home(),
      ),
    );
  }
}
