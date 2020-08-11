// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/router_utils.dart';
import 'package:fuel_calculator/screens/home/home.dart';
import 'package:fuel_calculator/screens/calculator/calculator.dart';
import 'package:fuel_calculator/models/profile/profile.dart';
import 'package:fuel_calculator/screens/profiler/profiler.dart';

class Router {
  static const homeScreen = '/';
  static const calculatorScreen = '/calculator-screen';
  static const profilerScreen = '/profiler-screen';
  static GlobalKey<NavigatorState> get navigatorKey =>
      getNavigatorKey<Router>();
  static NavigatorState get navigator => navigatorKey.currentState;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.homeScreen:
        return MaterialPageRoute(
          builder: (_) => Home(),
          settings: settings,
        );
      case Router.calculatorScreen:
        if (hasInvalidArgs<Profile>(args, isRequired: true)) {
          return misTypedArgsRoute<Profile>(args);
        }
        final typedArgs = args as Profile;
        return MaterialPageRoute(
          builder: (_) => Calculator(profile: typedArgs),
          settings: settings,
          fullscreenDialog: true,
        );
      case Router.profilerScreen:
        if (hasInvalidArgs<ProfilerArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<ProfilerArguments>(args);
        }
        final typedArgs = args as ProfilerArguments;
        return MaterialPageRoute(
          builder: (_) => Profiler(
              newProfile: typedArgs.newProfile,
              profile: typedArgs.profile,
              index: typedArgs.index),
          settings: settings,
          fullscreenDialog: true,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//Profiler arguments holder class
class ProfilerArguments {
  final bool newProfile;
  final Profile profile;
  final int index;
  ProfilerArguments(
      {@required this.newProfile,
      @required this.profile,
      @required this.index});
}
