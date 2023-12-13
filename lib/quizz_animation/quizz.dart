import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'q1.dart';
import 'q2.dart';
import 'q3.dart';

final _teams = <TeamMixin>[
  Question1(),
  Question2(),
  Question3(),
];

class DojoQuizz extends DojoWidget {
  DojoQuizz({
    Key? key,
  }) : super(key: key, dojoName: 'Quizz', teams: _teams);
}
