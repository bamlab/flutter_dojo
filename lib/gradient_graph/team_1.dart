import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

import 'data/data_point.dart';

class GradientGraphTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';
  final List<DataPoint> dataPoints = getDataPoints();

  @override
  State<GradientGraphTeam1> createState() => _GradientGraphTeam1State();
}

class _GradientGraphTeam1State extends State<GradientGraphTeam1> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
              alignment: Alignment.center,
              color: Colors.red,
              width: 100,
              height: 100,
              child: Text(
                'Team 1 - Gradient Graph',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              )),
        ),
      ),
    );
  }
}
