import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class AnimatedCircleTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<AnimatedCircleTeam3> createState() =>
      _AnimatedNavigationBarTeam3State();
}

class _AnimatedNavigationBarTeam3State extends State<AnimatedCircleTeam3> {
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
