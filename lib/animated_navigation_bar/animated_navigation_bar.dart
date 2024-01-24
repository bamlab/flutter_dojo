import 'package:bam_dojo/animated_navigation_bar/team_3.dart';
import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';

final _teams = <TeamMixin>[
  AnimatedNavigationBarTeam1(),
  AnimatedNavigationBarTeam2(),
  AnimatedNavigationBarTeam3(),
];

class DojoAnimatedNavigationBar extends DojoWidget {
  DojoAnimatedNavigationBar({
    Key? key,
  }) : super(key: key, dojoName: 'AnimatedNavigationBar', teams: _teams);
}
