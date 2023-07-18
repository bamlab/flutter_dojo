import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

final _teams = <TeamMixin>[
  RoundedCarouselTeam1(),
  RoundedCarouselTeam2(),
  RoundedCarouselTeam3(),
];

class DojoRoundedCarousel extends DojoWidget {
  DojoRoundedCarousel({
    Key? key,
  }) : super(key: key, dojoName: 'RoundedCarousel', teams: _teams);
}
