import 'package:flutter/material.dart';
import 'package:fuel_calculator/models/profile/profile.dart';
import 'package:fuel_calculator/routes/router.gr.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Profile>(ProfileAdapter());
  await Hive.openBox<Profile>('profiles');
  Profile test = Profile.init();
  print(test.capacity);
  test.gallonsToFull = 50.0;
  print(test.capacity);
  runApp(
    MaterialApp(
      initialRoute: Router.homeScreen,
      onGenerateRoute: Router.onGenerateRoute,
      navigatorKey: Router.navigatorKey,
      debugShowCheckedModeBanner: false,
    )
  );
}