import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

/// Design: https://dribbble.com/shots/10792593-Pulsating-cubes

final _teams = <TeamWidget>[
  const HoleCardsTeam1(),
  const HoleCardsTeam2(),
  const HoleCardsTeam3(),
];

class DojoHoleCards extends DojoWidget {
  DojoHoleCards({
    Key? key,
  }) : super(key: key, dojoName: 'HoleCards', teams: _teams);
}
