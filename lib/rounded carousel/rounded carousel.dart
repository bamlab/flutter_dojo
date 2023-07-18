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

const roundedCarouselImages = [
  'https://picsum.photos/200/400?index=12',
  'https://picsum.photos/200/400?index=15',
  'https://picsum.photos/200/400?index=16',
  'https://picsum.photos/200/400?index=24',
  'https://picsum.photos/200/400?index=32',
];

class DojoRoundedCarousel extends DojoWidget {
  DojoRoundedCarousel({
    Key? key,
  }) : super(key: key, dojoName: 'RoundedCarousel', teams: _teams);
}
