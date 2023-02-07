import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

/// Design: https://dribbble.com/shots/10792593-Pulsating-cubes

final _teams = <TeamMixin>[
  RipplingWaveTeam1(),
  RipplingWaveTeam2(),
  RipplingWaveTeam3(),
];

class DojoRipplingWave extends DojoWidget {
  DojoRipplingWave({
    Key? key,
  }) : super(key: key, dojoName: 'RipplingWave', teams: _teams);
}
