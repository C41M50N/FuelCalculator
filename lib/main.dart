import 'package:flutter/material.dart';
import 'package:fuel_calculator/screens/screens.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/profiler': (context) => Profiler(),
        '/calculator': (context) => Calculator()
      },
    )
  );
}