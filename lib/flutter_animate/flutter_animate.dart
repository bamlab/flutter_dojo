import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

final _teams = <TeamMixin>[
  FlutterAnimateTeam1(),
  FlutterAnimateTeam2(),
  FlutterAnimateTeam3(),
];

class DojoFlutterAnimate extends DojoWidget {
  DojoFlutterAnimate({
    Key? key,
  }) : super(key: key, dojoName: 'FlutterAnimate', teams: _teams);
}
