import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

/// Design: https://dribbble.com/shots/10792593-Pulsating-cubes

final _teams = <TeamMixin>[
  DragThisTeam1(),
  DragThisTeam2(),
  DragThisTeam3(),
];

class DojoDragThis extends DojoWidget {
  DojoDragThis({
    Key? key,
  }) : super(key: key, dojoName: 'DragThis', teams: _teams);
}
