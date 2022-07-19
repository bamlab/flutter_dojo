import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

/// Design: https://dribbble.com/shots/10792593-Pulsating-cubes

final _teams = <TeamWidget>[
  const AnimatedLikesTeam1(),
  const AnimatedLikesTeam2(),
  const AnimatedLikesTeam3(),
];

class DojoAnimatedLikes extends DojoWidget {
  DojoAnimatedLikes({
    Key? key,
  }) : super(key: key, dojoName: 'Animated Likes', teams: _teams);
}
