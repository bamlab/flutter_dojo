import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

// Design: https://twitter.com/philipcdavis/status/1550133881168269312

final _teams = <TeamMixin>[
  const ImprovedCounterAppTeam1(),
  const ImprovedCounterAppTeam2(),
  const ImprovedCounterAppTeam3(),
];

class DojoImprovedCounterApp extends DojoWidget {
  DojoImprovedCounterApp({
    Key? key,
  }) : super(key: key, dojoName: 'ImprovedCounterApp', teams: _teams);
}
