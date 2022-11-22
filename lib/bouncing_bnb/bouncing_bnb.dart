import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

// Design: https://twitter.com/philipcdavis/status/1550133881168269312


final _teams = <TeamMixin>[
  const BouncingBNBTeam1(),
  const BouncingBNBTeam2(),
  const BouncingBNBTeam3(),
];

class DojoBouncingBNB extends DojoWidget {
  DojoBouncingBNB({
    Key? key,
  }) : super(key: key, dojoName: 'BouncingBNB', teams: _teams);
}
