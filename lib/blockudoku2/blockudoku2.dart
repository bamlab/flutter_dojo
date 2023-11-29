import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

final _teams = <TeamMixin>[
  Blockudoku2Team1(),
  Blockudoku2Team2(),
  Blockudoku2Team3(),
];

class DojoBlockudoku2 extends DojoWidget {
  DojoBlockudoku2({
    Key? key,
  }) : super(key: key, dojoName: 'Blockudoku2', teams: _teams);
}
