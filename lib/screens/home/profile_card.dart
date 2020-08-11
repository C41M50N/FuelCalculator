import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuel_calculator/models/profile/profile.dart';
import 'package:fuel_calculator/routes/router.gr.dart';

class ProfileCard extends StatelessWidget {

  final Profile profile;
  final Function edit, delete;

  ProfileCard({this.profile, this.edit, this.delete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(13.0, 13.0, 13.0, 5.0),
      child: ListTile(
        onTap: () {
          navigateToCalculator(context, this.profile);
        },
        title: Text(
          this.profile.name,
        ),
        subtitle: Text(
          'Tank Capacity: ${this.profile.capacity.toStringAsFixed(3)}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              child: IconButton(
                icon: Icon(Icons.edit, color: Colors.orangeAccent),
                onPressed: edit
              ),
            ),
            SizedBox(width: 7.69420),
            Container(
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.redAccent),
                onPressed: delete,
              )
            )
          ],
        ),
      ),
    );
  }
}

void navigateToCalculator(BuildContext context, Profile profile) {
  Router.navigator.pushNamed(Router.calculatorScreen, arguments: profile);
}