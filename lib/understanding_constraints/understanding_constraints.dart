import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

final _teams = <TeamMixin>[
  UnderstandingConstraintsTeam1(),
  UnderstandingConstraintsTeam2(),
  UnderstandingConstraintsTeam3(),
];

class DojoUnderstandingConstraints extends DojoWidget {
  DojoUnderstandingConstraints({
    Key? key,
  }) : super(key: key, dojoName: 'UnderstandingConstraints', teams: _teams);
}
