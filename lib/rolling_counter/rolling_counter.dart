import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

/// Design: https://dribbble.com/shots/10792593-Pulsating-cubes

final _teams = <TeamWidget>[
  const RollingCounterTeam1(),
  const RollingCounterTeam2(),
  const RollingCounterTeam3(),
];

class DojoRollingCounter extends DojoWidget {
  DojoRollingCounter({
    Key? key,
  }) : super(key: key, dojoName: 'Rolling Counter', teams: _teams);
}
