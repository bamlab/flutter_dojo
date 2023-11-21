import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

final _teams = <TeamMixin>[
  HeroAnimationsTeam1(),
  HeroAnimationsTeam2(),
  HeroAnimationsTeam3(),
];

class DojoHeroAnimations extends DojoWidget {
  DojoHeroAnimations({
    Key? key,
  }) : super(key: key, dojoName: 'HeroAnimations', teams: _teams);
}
