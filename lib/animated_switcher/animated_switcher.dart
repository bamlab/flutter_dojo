import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

final _teams = <TeamMixin>[
  AnimatedSwitcherTeam1(),
  AnimatedSwitcherTeam2(),
  AnimatedSwitcherTeam3(),
];

class DojoAnimatedSwitcher extends DojoWidget {
  DojoAnimatedSwitcher({
    Key? key,
  }) : super(key: key, dojoName: 'AnimatedSwitcher', teams: _teams);
}
