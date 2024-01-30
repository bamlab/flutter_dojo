import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class AnimatedCircleTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<AnimatedCircleTeam1> createState() => _AnimatedCircleTeam1State();
}

class _AnimatedCircleTeam1State extends State<AnimatedCircleTeam1> {
  var index = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: SizedBox(
          width: 100,
          height: 100,
          child: ColoredBox(
            color: Colors.black,
          ),
        )),
      ),
    );
  }
}
