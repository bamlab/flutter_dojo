import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

final _teams = <TeamMixin>[
  ImplicitAnimationTeam1(),
  ImplicitAnimationTeam2(),
  ImplicitAnimationTeam3(),
];

class DojoImplicitAnimation extends DojoWidget {
  DojoImplicitAnimation({
    Key? key,
  }) : super(key: key, dojoName: 'ImplicitAnimation', teams: _teams);
}
