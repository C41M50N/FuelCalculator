import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuel_calculator/models/profile/profile.dart';
import 'package:fuel_calculator/routes/router.gr.dart';
import 'package:fuel_calculator/screens/profiler/fuel_capacity_label.dart';
import 'package:hive/hive.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class ProfilerForm extends StatefulWidget {

  final bool newProfile;
  final Profile profile;
  final int index;

  ProfilerForm({Key key, this.newProfile ,this.profile, this.index}) : super(key: key);

  @override
  _ProfilerFormState createState() => _ProfilerFormState();
}

class _ProfilerFormState extends State<ProfilerForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int _index = 0;
  Profile _profile = Profile.init();
  double initialValue = -1;

  @override
  void initState() {
    this.initialValue = widget.profile.percentToFull * 100;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // print(widget.profile.toString());
    if (!widget.newProfile) this._profile = widget.profile;

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
                      // width: 100.0,
                      // height: 100.0,
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
                  initialValue: this.initialValue,
                  onChange: (double value) {
                    setState(() {
                      this._profile.percentToFull = value / 100.0;
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
                )
              ],
            ),

            //? Gallons Input Field
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: TextFormField(
                initialValue: this._profile.gallonsToFull.toString(),
                keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.singleLineFormatter,
                  FilteringTextInputFormatter(RegExp('[-]'), allow: false),
                  FilteringTextInputFormatter(RegExp('[,]'), allow: false),
                  FilteringTextInputFormatter(RegExp('[ ]'), allow: false)
                ],
                onChanged: (text) {
                  print('Changed');
                  setState(() {
                    this._profile.gallonsToFull = double.parse(text);
                  });
                  // setState(() {
                  //   this._profile.gallonsToFull = double.parse(text);
                  //   print('Changed');
                  // });
                },
                onSaved: (val) {
                  this._profile.gallonsToFull = double.parse(val);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a number';
                  } else
                    return null;
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.local_gas_station, size: 35.0),
                  labelText: 'Number of gallons',
                  helperText: 'Enter the number of gallons it took to fill your vehicle'
                ),
              ),
            ),
            SizedBox(height: 20.0),

            //? Submit Button
            RaisedButton.icon(
              color: Colors.green[400],
              onPressed: () {
                // if valid add Profile object to list of objects
                if (_formKey.currentState.validate()) {
                  // If all data are correct then save data to out variables
                  _formKey.currentState.save();
                  Box<Profile> box = Hive.box('profiles');
                  if (_index == -1) {
                    box.add(this._profile);
                  } else {
                    box.putAt(_index, this._profile);
                  }
                  navigateHome(context);
                }
              },
              icon: Icon(
                Icons.check,
                color: Colors.black,
              ),
              label: Text(
                'Submit',
                style: TextStyle(color: Colors.black87),
              )
            ),
            SizedBox(height: 20.0),

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