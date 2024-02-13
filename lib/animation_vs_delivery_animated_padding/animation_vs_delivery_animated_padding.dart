import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

final _teams = <TeamMixin>[
  AnimationVsDeliveryAnimatedPaddingTeam1(),
  AnimationVsDeliveryAnimatedPaddingTeam2(),
  AnimationVsDeliveryAnimatedPaddingTeam3(),
];

class DojoAnimationVsDeliveryAnimatedPadding extends DojoWidget {
  DojoAnimationVsDeliveryAnimatedPadding({
    Key? key,
  }) : super(key: key, dojoName: 'AnimationVsDeliveryAnimatedPadding', teams: _teams);
}
