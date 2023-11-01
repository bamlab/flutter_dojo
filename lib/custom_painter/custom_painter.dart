import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

final _teams = <TeamMixin>[
  CustomPainterTeam1(),
  CustomPainterTeam2(),
  CustomPainterTeam3(),
];

class DojoCustomPainter extends DojoWidget {
  DojoCustomPainter({
    Key? key,
  }) : super(key: key, dojoName: 'CustomPainter', teams: _teams);
}
