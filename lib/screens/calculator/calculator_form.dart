import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuel_calculator/models/profile/profile.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CalculatorForm extends StatefulWidget {
  final Profile profile;

  CalculatorForm({Key key, this.profile}) : super(key: key);

  @override
  _CalculatorFormState createState() => _CalculatorFormState();
}

class _CalculatorFormState extends State<CalculatorForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Profile _profile = Profile.init();
  double _cost = 0.0;

  @override
  Widget build(BuildContext context) {
    this._profile = widget.profile;

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidate: false,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(height: 70.0),

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
                  initialValue: 50,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 30.0, 0.0),
              child: TextFormField(
                initialValue: '',
                keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.singleLineFormatter,
                  FilteringTextInputFormatter(RegExp('[-]'), allow: false),
                  FilteringTextInputFormatter(RegExp('[,]'), allow: false),
                  FilteringTextInputFormatter(RegExp('[ ]'), allow: false)
                ],
                onChanged: (text) {
                  setState(() {
                    this._cost = double.parse(text);
                  });
                },
                onSaved: (val) {
                  this._cost = double.parse(val);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter an amount';
                  } else
                    return null;
                },
                decoration: InputDecoration(
                    icon: Icon(Icons.attach_money, size: 35.0),
                    labelText: 'Cost per gallon',
                    helperText: 'Enter the gas station\'s cost per gallon'),
              ),
            ),
            SizedBox(height: 50.0),
            Center(
              child: Column(
                children: <Widget>[
                  Text(
                    'Cost to Fill',
                    style:
                        TextStyle(fontSize: 23.0, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    '\$${(((1.0 - this._profile.percentToFull) * this._profile.capacity) * this._cost).toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.normal),
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
