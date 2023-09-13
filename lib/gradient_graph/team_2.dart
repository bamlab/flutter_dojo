import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

import 'data/data_point.dart';

class GradientGraphTeam2 extends StatefulWidget with TeamMixin {
  final teamName = 'Team2';
  final List<DataPoint> dataPoints = getDataPoints();

  @override
  State<GradientGraphTeam2> createState() => _GradientGraphTeam2State();
}

class _GradientGraphTeam2State extends State<GradientGraphTeam2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            alignment: Alignment.center,
            color: Colors.blue,
            width: 100,
            height: 100,
            child: Text(
              'Team 2 - Gradient Graph',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
