import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

/// Design: https://dribbble.com/shots/10792593-Pulsating-cubes

final _teams = <TeamMixin>[
  UselessSliderTeam1(),
  UselessSliderTeam2(),
  UselessSliderTeam3(),
];

class DojoUselessSlider extends DojoWidget {
  DojoUselessSlider({
    Key? key,
  }) : super(key: key, dojoName: 'UselessSlider', teams: _teams);
}
