import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class UnderstandingConstraintsTeam2 extends StatefulWidget with TeamMixin {
  final teamName = 'Team2';

  @override
  State<UnderstandingConstraintsTeam2> createState() => _UnderstandingConstraintsTeam2State();
}

class _UnderstandingConstraintsTeam2State extends State<UnderstandingConstraintsTeam2> {
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