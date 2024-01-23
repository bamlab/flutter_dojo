import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

final _teams = <TeamMixin>[
  AppBarTeam1(),
  AppBarTeam2(),
  AppBarTeam3(),
];

class DojoProgressBar extends DojoWidget {
  DojoProgressBar({
    Key? key,
  }) : super(key: key, dojoName: 'AppBar', teams: _teams);
}
