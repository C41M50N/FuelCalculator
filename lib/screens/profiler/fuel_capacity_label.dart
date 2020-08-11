import 'package:flutter/material.dart';
import 'package:fuel_calculator/models/profile/profile.dart';

class FuelCapacityLabel extends StatelessWidget {

  FuelCapacityLabel({this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            'Vehicle Fuel Capacity',
            style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.normal),
          ),
          SizedBox(height: 5.0),
          Text(
            '${this.profile.capacity.toStringAsFixed(3)} gallons',
            style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.normal),
          )
        ],
      )
    );
  }
}