import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuel_calculator/models/profile/profile.dart';

class ProfileCard extends StatelessWidget {

  final Profile profile;
  final Function edit, delete;

  ProfileCard({this.profile, this.edit, this.delete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      child: ListTile(
        onTap: () {
//          dynamic result = Navigator.pushNamed(context, '/profiler');
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
//                color: Colors.orangeAccent,
              child: IconButton(
                icon: Icon(Icons.edit, color: Colors.orangeAccent),
                onPressed: edit
              ),
            ),
            SizedBox(width: 7.69420),
            Container(
//                color: Colors.redAccent,
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
