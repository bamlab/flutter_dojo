import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

final _teams = <TeamMixin>[
  RiveTeam1(),
  RiveTeam2(),
  RiveTeam3(),
];

class DojoRive extends DojoWidget {
  DojoRive({
    Key? key,
  }) : super(key: key, dojoName: 'Rive', teams: _teams);
}
