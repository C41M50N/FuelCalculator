import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuel_calculator/models/profile/profile.dart';
import 'package:fuel_calculator/routes/router.gr.dart';
import 'package:fuel_calculator/screens/profiler/fuel_capacity_label.dart';
import 'package:hive/hive.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class ProfilerForm2 extends StatefulWidget {

  final Profile profile;
  final int index;

  ProfilerForm2({Key key, this.profile, this.index}) : super(key: key);

  @override
  _ProfilerFormState createState() => _ProfilerFormState();
}

class _ProfilerFormState extends State<ProfilerForm2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int _index = 0;
  Profile _profile = Profile.init();

  @override
  Widget build(BuildContext context) {

    this._profile = widget.profile;
    this._index = widget.index;

    print(this._profile.toString());

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidate: false,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            //? Name Input Field
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
              child: TextFormField(
                initialValue: this._profile.name,
                onChanged: (text) {
                  this._profile.name = text;
                },
                onSaved: (val) {
                  this._profile.name = val;
                },
                validator: (value) {
                  if (value.isEmpty)
                    return 'Please enter a name';
                  else
                    return null;
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.directions_car, size: 35.0),
                  labelText: 'Name',
                  helperText: 'Enter name for vehicle profile'
                ),
              ),
            ),
            SizedBox(height: 140.0),

            //? Fuel Gauge Slider
            Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  top: -142,
                  left: -105,
                  child: FittedBox(
                    child: Image.asset(
                      'assets/images/fuel_gauge2.png',
                      scale: 0.55,
                      width: 410,
                      height: 410,
                    ),
                  ),
                ),     
                SleekCircularSlider(
                  appearance: CircularSliderAppearance(
                    startAngle: 210, // 210
                    size: 200,
                    angleRange: 120,
                    customWidths: CustomSliderWidths(trackWidth: 1),
                    customColors: CustomSliderColors(
                        trackColor: Colors.black45,
                        progressBarColors: [
                          Colors.redAccent,
                          Colors.amber,
                          Colors.green,
                        ],
                        gradientStartAngle: 210,
                        gradientEndAngle: 330
                    ),
                  ),
                  min: 0.0,
                  max: 100.0,
                  initialValue: this._profile.percentToFull * 100,
                  onChange: (double value) {
                    setState(() {
                      this._profile.percentToFull = value / 100.0;
                      print("CHanged");
                    });
                  },
                  innerWidget: (double value) {
                    return Center(
                      child: Text(
                        value.ceil().toInt().toString() + "%",
                        style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
              ]
            ),
            
            //? Capacity Label
            FuelCapacityLabel(profile: this._profile)
          ],
        ),
      ),
    );
  }
}

void navigateHome(BuildContext context) {
  Router.navigator.pushNamed(Router.homeScreen);
}