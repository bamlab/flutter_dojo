import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

/// Design: https://dribbble.com/shots/10792593-Pulsating-cubes

final _teams = <TeamWidget>[
  const CardShredderTeam1(),
  const CardShredderTeam2(),
  const CardShredderTeam3(),
];

class DojoCardShredder extends DojoWidget {
  DojoCardShredder({
    Key? key,
  }) : super(key: key, dojoName: 'Card Shredder', teams: _teams);
}
