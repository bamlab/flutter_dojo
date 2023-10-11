import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

final _teams = <TeamMixin>[
  TweenAnimationBuilderExampleTeam1(),
  TweenAnimationBuilderExampleTeam2(),
  TweenAnimationBuilderExampleTeam3(),
];

class DojoTweenAnimationBuilderExample extends DojoWidget {
  DojoTweenAnimationBuilderExample({
    Key? key,
  }) : super(key: key, dojoName: 'TweenAnimationBuilderExample', teams: _teams);
}
