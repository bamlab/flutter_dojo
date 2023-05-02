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

class DojoRipplingWave2 extends DojoWidget {
  DojoRipplingWave2({
    Key? key,
  }) : super(key: key, dojoName: 'RipplingWave2', teams: _teams);
}
