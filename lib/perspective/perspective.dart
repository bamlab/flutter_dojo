import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

/// Design: https://dribbble.com/shots/10792593-Pulsating-cubes

final _teams = <TeamWidget>[
  const PerspectiveTeam1(),
  const PerspectiveTeam2(),
  const PerspectiveTeam3(),
];

class DojoPerspective extends DojoWidget {
  DojoPerspective({
    Key? key,
  }) : super(key: key, dojoName: 'Perspective', teams: _teams);
}
