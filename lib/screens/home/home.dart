import 'package:flutter/material.dart';
import 'package:fuel_calculator/models/profile/profile.dart';
import 'package:fuel_calculator/screens/home/profile_card.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Profile> profiles = [
    Profile(name: "Profile1", percentToFull: 0.5, gallonsToFull: 5.679),
    Profile(name: "2017 Chevrolet Malibu", percentToFull: 0.25, gallonsToFull: 2.8395),
    Profile(name: "2015 Chevrolet Impala", percentToFull: 0.15, gallonsToFull: 10.541),
    Profile(name: "2016 Nissan Altima", percentToFull: 0.0, gallonsToFull: 30.125)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: profiles.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ProfileCard(
                profile: profiles[index],
                edit: () {
                  setState(() {

                  });
                },
                delete: () {
                  setState(() {
                    profiles.remove(profiles[index]);
                  });
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.pushNamed(context, '/profiler');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
