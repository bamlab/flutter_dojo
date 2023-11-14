import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class AnimatedSwitcherTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<AnimatedSwitcherTeam1> createState() => _AnimatedSwitcherTeam1State();
}

class _AnimatedSwitcherTeam1State extends State<AnimatedSwitcherTeam1> {
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