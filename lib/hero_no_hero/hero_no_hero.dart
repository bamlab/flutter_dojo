import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

// Design: https://twitter.com/philipcdavis/status/1550133881168269312


final _teams = <TeamMixin>[
  const HeroNoHeroTeam1(),
  const HeroNoHeroTeam2(),
  const HeroNoHeroTeam3(),
];

class DojoHeroNoHero extends DojoWidget {
  DojoHeroNoHero({
    Key? key,
  }) : super(key: key, dojoName: 'HeroNoHero', teams: _teams);
}
