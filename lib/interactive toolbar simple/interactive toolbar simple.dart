import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

final _teams = <TeamMixin>[
  InteractiveToolbarSimpleTeam1(),
  InteractiveToolbarSimpleTeam2(),
  InteractiveToolbarSimpleTeam3(),
];

class DojoInteractiveToolbarSimple extends DojoWidget {
  DojoInteractiveToolbarSimple({
    Key? key,
  }) : super(key: key, dojoName: 'InteractiveToolbarSimple', teams: _teams);
}
