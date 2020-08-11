import 'package:auto_route/auto_route_annotations.dart';
import 'package:fuel_calculator/screens/screens.dart';

@autoRouter
class $Router {
  
  @initial
  Home homeScreen;

  @MaterialRoute(fullscreenDialog: true)
  Calculator calculatorScreen;

  @MaterialRoute(fullscreenDialog: true)
  Profiler profilerScreen;
}