import 'dart:core';

import 'package:flutter/material.dart';
import 'package:fuel_calculator/models/profile/profile.dart';
import 'package:fuel_calculator/routes/router.gr.dart';
import 'package:fuel_calculator/screens/home/profile_card.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Profile> profiles = [
    // ? Test Data
    // Profile( name: "Profile1",                 percentToFull: 0.5,   gallonsToFull: 5.679 ),
    // Profile( name: "2017 Chevrolet Malibu",    percentToFull: 0.25,  gallonsToFull: 2.8395 ),
    // Profile( name: "2015 Chevrolet Impala",    percentToFull: 0.15,  gallonsToFull: 10.541 ),
    // Profile( name: "2016 Nissan Altima",       percentToFull: 0.0,   gallonsToFull: 30.125 ),
    // Profile( name: '2020 Chevrolet Impala',    percentToFull: 1.0,   gallonsToFull: 18.5 ),
    // Profile( name: '2020 Chevrolet Blazer',    percentToFull: 1.0,   gallonsToFull: 20.57 ),
    // Profile( name: '2020 Chevrolet Camaro',    percentToFull: 0.5,   gallonsToFull: 9.5 ),
    // Profile( name: '2020 Chevrolet Corvette',  percentToFull: 1.0,   gallonsToFull: 18.5 ),
    // Profile( name: '2020 Chevrolet Sonic',     percentToFull: 1.0,   gallonsToFull: 12.2 ),
    // Profile( name: '2000 Chevrolet Impala',    percentToFull: 1.0,   gallonsToFull: 17.0 )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: Hive.box<Profile>('profiles').listenable(),
          builder: (context, Box<Profile> box, _) {
            if (box.values.isEmpty) {
              return Center(
                child: Text(
                  'Add a profile using the botton below',
                  style: TextStyle(
                    color: Colors.grey[700]
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: box.values.length,
                itemBuilder: (context, index) {
                  Profile currentProfile = box.getAt(index);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ProfileCard(
                      profile: currentProfile,
                      edit: () {
                        navigateToProfiler(context, false, currentProfile, index);
                      },
                      delete: () async {
                        await box.deleteAt(index);
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
        onPressed: () {
          navigateToProfiler(context, true, Profile.init(), -1);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}

void navigateToProfiler(BuildContext context, bool newProfile, Profile profile, int index) {
  Router.navigator.pushNamed(Router.profilerScreen, arguments: ProfilerArguments(newProfile: newProfile, profile: profile, index: index));
}
