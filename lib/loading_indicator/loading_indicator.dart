import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

const g1c1 = Color.fromRGBO(244, 221, 88, 0.9);
const g1c2 = Color.fromRGBO(208, 53, 242, 0.9);
const g2c1 = Color.fromRGBO(225, 49, 243, 0.9);
const g2c2 = Color.fromRGBO(5, 0, 242, 0.9);
const g3c1 = Color.fromRGBO(230, 53, 35, 0.9);
const g3c2 = Color.fromRGBO(250, 245, 81, 0.9);

final _teams = <TeamMixin>[
  LoadingIndicatorTeam1(),
  LoadingIndicatorTeam2(),
  LoadingIndicatorTeam3(),
];

class DojoLoadingIndicator extends DojoWidget {
  DojoLoadingIndicator({
    Key? key,
  }) : super(key: key, dojoName: 'LoadingIndicator', teams: _teams);
}
