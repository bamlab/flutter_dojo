import 'package:bam_dojo/animated_circle/team_3.dart';
import 'package:bam_dojo/animated_circle/team_4.dart';
import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';

final _teams = <TeamMixin>[
  AnimatedCircleTeam1(),
  AnimatedCircleTeam2(),
  AnimatedCircleTeam3(),
  AnimatedCircleTeam4(),
];

class DojoAnimatedCircle extends DojoWidget {
  DojoAnimatedCircle({
    Key? key,
  }) : super(key: key, dojoName: 'AnimatedCircle', teams: _teams);
}
