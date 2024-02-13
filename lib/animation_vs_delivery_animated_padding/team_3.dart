import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class AnimationVsDeliveryAnimatedPaddingTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<AnimationVsDeliveryAnimatedPaddingTeam3> createState() => _AnimationVsDeliveryAnimatedPaddingTeam3State();
}

class _AnimationVsDeliveryAnimatedPaddingTeam3State extends State<AnimationVsDeliveryAnimatedPaddingTeam3> {
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