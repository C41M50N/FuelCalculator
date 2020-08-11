import 'package:flutter/material.dart';
import 'package:fuel_calculator/models/profile/profile.dart';
import 'package:fuel_calculator/screens/calculator/calculator_form.dart';

class Calculator extends StatefulWidget {
  final Profile profile;

  @override
  _CalculatorState createState() => _CalculatorState();

  const Calculator({@required this.profile});
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.profile.name),
      ),
      body: CalculatorForm(profile: widget.profile),
      backgroundColor: Colors.white,
    );
  }
}
