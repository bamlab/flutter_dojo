import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class UnderstandingConstraintsTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<UnderstandingConstraintsTeam3> createState() => _UnderstandingConstraintsTeam3State();
}

class _UnderstandingConstraintsTeam3State extends State<UnderstandingConstraintsTeam3> {
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