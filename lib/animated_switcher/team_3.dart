import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class AnimatedSwitcherTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<AnimatedSwitcherTeam3> createState() => _AnimatedSwitcherTeam3State();
}

class _AnimatedSwitcherTeam3State extends State<AnimatedSwitcherTeam3> {
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