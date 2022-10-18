import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

/// Design: https://dribbble.com/shots/10792593-Pulsating-cubes

final _teams = <TeamMixin>[
  ShakingFieldTeam1(),
  ShakingFieldTeam2(),
  ShakingFieldTeam3(),
];

class DojoShakingField extends DojoWidget {
  DojoShakingField({
    Key? key,
  }) : super(key: key, dojoName: 'ShakingField', teams: _teams);
}
