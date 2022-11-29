import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';

// Design: https://twitter.com/philipcdavis/status/1550133881168269312

final _teams = <TeamMixin>[
  const OutOfScreenTeam1(),
];

class DojoOutOfScreen extends DojoWidget {
  DojoOutOfScreen({
    Key? key,
  }) : super(key: key, dojoName: 'OutOfScreen', teams: _teams);
}
