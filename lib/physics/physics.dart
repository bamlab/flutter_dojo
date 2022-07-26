import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

// Design: https://twitter.com/philipcdavis/status/1550133881168269312


final _teams = <TeamWidget>[
  const PhysicsTeam1(),
  const PhysicsTeam2(),
  const PhysicsTeam3(),
];

class DojoPhysics extends DojoWidget {
  DojoPhysics({
    Key? key,
  }) : super(key: key, dojoName: 'Physics', teams: _teams);
}
