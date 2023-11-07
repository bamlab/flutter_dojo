import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class RiveTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<RiveTeam3> createState() => _RiveTeam3State();
}

class _RiveTeam3State extends State<RiveTeam3> {
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