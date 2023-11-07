import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class RiveTeam2 extends StatefulWidget with TeamMixin {
  final teamName = 'Team2';

  @override
  State<RiveTeam2> createState() => _RiveTeam2State();
}

class _RiveTeam2State extends State<RiveTeam2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            width: 100,
            height: 100,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}