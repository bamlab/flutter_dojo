import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

// Design: https://twitter.com/philipcdavis/status/1550133881168269312

final _teams = <TeamMixin>[
  const RefreshPlusTeam1(),
  const RefreshPlusTeam2(),
  const RefreshPlusTeam3(),
];

class DojoRefreshPlus extends DojoWidget {
  DojoRefreshPlus({
    Key? key,
  }) : super(key: key, dojoName: 'RefreshPlus', teams: _teams);
}
