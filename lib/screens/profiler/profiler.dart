import 'package:flutter/material.dart';

class Profiler extends StatefulWidget {
  @override
  _ProfilerState createState() => _ProfilerState();
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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[

        ],
      ),
    );
  }
}
