import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class AnimatedSwitcherTeam2 extends StatefulWidget with TeamMixin {
  final teamName = 'Team2';

  @override
  State<AnimatedSwitcherTeam2> createState() => _AnimatedSwitcherTeam2State();
}

class _AnimatedSwitcherTeam2State extends State<AnimatedSwitcherTeam2> {
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