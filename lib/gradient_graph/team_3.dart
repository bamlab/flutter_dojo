import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

import 'data/data_point.dart';

class GradientGraphTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';
  final List<DataPoint> dataPoints = getDataPoints();

  @override
  State<GradientGraphTeam3> createState() => _GradientGraphTeam3State();
}

class _GradientGraphTeam3State extends State<GradientGraphTeam3> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            alignment: Alignment.center,
            color: Colors.green,
            width: 100,
            height: 100,
            child: Text(
              'Team 3 - Gradient Graph',
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
