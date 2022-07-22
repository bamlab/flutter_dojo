import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

// Design: https://twitter.com/philipcdavis/status/1550133881168269312


final _teams = <TeamWidget>[
  const ClothTeam1(),
  const ClothTeam2(),
  const ClothTeam3(),
];

class DojoCloth extends DojoWidget {
  DojoCloth({
    Key? key,
  }) : super(key: key, dojoName: 'Cloth', teams: _teams);
}
