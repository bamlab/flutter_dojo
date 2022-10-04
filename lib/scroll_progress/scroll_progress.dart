import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

/// Design: https://dribbble.com/shots/10792593-Pulsating-cubes

final _teams = <TeamMixin>[
  ScrollProgressTeam1(),
  ScrollProgressTeam2(),
  ScrollProgressTeam3(),
];

class DojoScrollProgress extends DojoWidget {
  DojoScrollProgress({
    Key? key,
  }) : super(key: key, dojoName: 'ScrollProgress', teams: _teams);
}
