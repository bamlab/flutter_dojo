import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

final _teams = <TeamMixin>[
  GradientGraphTeam1(),
  GradientGraphTeam2(),
  GradientGraphTeam3(),
];

class DojoGradientGraph extends DojoWidget {
  DojoGradientGraph({
    Key? key,
  }) : super(key: key, dojoName: 'GradientGraph', teams: _teams);
}
