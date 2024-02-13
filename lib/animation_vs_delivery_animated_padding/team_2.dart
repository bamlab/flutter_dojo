import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class AnimationVsDeliveryAnimatedPaddingTeam2 extends StatefulWidget with TeamMixin {
  final teamName = 'Team2';

  @override
  State<AnimationVsDeliveryAnimatedPaddingTeam2> createState() => _AnimationVsDeliveryAnimatedPaddingTeam2State();
}

class _AnimationVsDeliveryAnimatedPaddingTeam2State extends State<AnimationVsDeliveryAnimatedPaddingTeam2> {
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