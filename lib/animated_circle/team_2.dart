import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class AnimatedCircleTeam2 extends StatefulWidget with TeamMixin {
  final teamName = 'Team2';

  @override
  State<AnimatedCircleTeam2> createState() => _AnimatedCircleTeam2State();
}

class _AnimatedCircleTeam2State extends State<AnimatedCircleTeam2> {
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
