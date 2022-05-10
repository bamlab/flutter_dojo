/// Design help:
///   - 3D card: https://codepen.io/lulupointu/pen/NWyNerz
///   - Mouse effect: https://codepen.io/lulupointu/pen/RwQaExL

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

import 'team_1.dart';

final _teams = <TeamWidget>[
  const CardHoverTeam1(),
];

class DojoCardHover extends DojoWidget {
  DojoCardHover({
    Key? key,
  }) : super(key: key, dojoName: 'CardHover ', teams: _teams);
}
