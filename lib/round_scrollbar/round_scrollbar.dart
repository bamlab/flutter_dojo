import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

/// Design: https://dribbble.com/shots/10792593-Pulsating-cubes

final _teams = <TeamMixin>[
  RoundScrollbarTeam1(),
  RoundScrollbarTeam2(),
  RoundScrollbarTeam3(),
];

class DojoRoundScrollbar extends DojoWidget {
  DojoRoundScrollbar({
    Key? key,
  }) : super(key: key, dojoName: 'RoundScrollbar', teams: _teams);
}
