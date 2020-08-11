import 'package:flutter/material.dart';
import 'package:fuel_calculator/models/profile/profile.dart';
import 'package:fuel_calculator/screens/profiler/profiler_form.dart';
import 'package:fuel_calculator/screens/profiler/profiler_form2.dart';

class Profiler extends StatefulWidget {
  final bool newProfile;
  final Profile profile;
  final int index;

  @override
  _ProfilerState createState() => _ProfilerState();

  const Profiler({
    @required this.newProfile,
    @required this.profile,
    @required this.index
  });
}

class _ProfilerState extends State<Profiler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profiler',
        ),
      ),
      body: ProfilerForm(newProfile: widget.newProfile, profile: widget.profile, index: widget.index)
    );
  }
}
