import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

final _teams = <TeamMixin>[
  ProgressBarTeam1(),
  ProgressBarTeam2(),
  ProgressBarTeam3(),
];

class DojoProgressBar extends DojoWidget {
  DojoProgressBar({
    Key? key,
  }) : super(key: key, dojoName: 'ProgressBar', teams: _teams);
}
