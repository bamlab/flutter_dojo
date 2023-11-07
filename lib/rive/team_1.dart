import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class RiveTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<RiveTeam1> createState() => _RiveTeam1State();
}

class _RiveTeam1State extends State<RiveTeam1> {
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