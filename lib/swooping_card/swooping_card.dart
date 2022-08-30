import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

/// Design: https://dribbble.com/shots/10792593-Pulsating-cubes

final _teams = <TeamWidget>[
  const SwoopingCardTeam1(),
  const SwoopingCardTeam2(),
  const SwoopingCardTeam3(),
];

class DojoSwoopingCard extends DojoWidget {
  DojoSwoopingCard({
    Key? key,
  }) : super(key: key, dojoName: 'SwoopingCard', teams: _teams);
}
