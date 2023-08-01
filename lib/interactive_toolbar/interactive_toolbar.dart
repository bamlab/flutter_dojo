import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

final _teams = <TeamMixin>[
  InteractiveToolbarTeam1(),
  InteractiveToolbarTeam2(),
  InteractiveToolbarTeam3(),
];

class DojoInteractiveToolbar extends DojoWidget {
  DojoInteractiveToolbar({
    Key? key,
  }) : super(key: key, dojoName: 'InteractiveToolbar', teams: _teams);
}
