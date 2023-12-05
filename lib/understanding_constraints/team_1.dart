import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class UnderstandingConstraintsTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<UnderstandingConstraintsTeam1> createState() => _UnderstandingConstraintsTeam1State();
}

class _UnderstandingConstraintsTeam1State extends State<UnderstandingConstraintsTeam1> {
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