import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

// Design: https://twitter.com/philipcdavis/status/1550133881168269312

final _teams = <TeamMixin>[
  const IconMorphTeam1(),
  const IconMorphTeam2(),
  const IconMorphTeam3(),
];

class DojoIconMorph extends DojoWidget {
  DojoIconMorph({
    Key? key,
  }) : super(key: key, dojoName: 'IconMorph', teams: _teams);
}
