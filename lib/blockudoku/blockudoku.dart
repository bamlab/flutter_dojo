import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

final _teams = <TeamMixin>[
  BlockudokuTeam1(),
  BlockudokuTeam2(),
  BlockudokuTeam3(),
];

class DojoBlockudoku extends DojoWidget {
  DojoBlockudoku({
    Key? key,
  }) : super(key: key, dojoName: 'Blockudoku', teams: _teams);
}
