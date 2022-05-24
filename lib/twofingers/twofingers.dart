import 'package:bam_dojo/helpers/team_class.dart';
import 'package:bam_dojo/twofingers/team_1.dart';
import 'package:bam_dojo/twofingers/team_2.dart';
import 'package:bam_dojo/twofingers/team_3.dart';
import 'package:flutter/material.dart';

final _teams = <TeamWidget>[
  const TwoFingersTeam1(),
  const TwoFingersTeam2(),
  const TwoFingersTeam3()
];

class TwoFingerDojo extends DojoWidget {
  TwoFingerDojo({
    Key? key,
  }) : super(key: key, dojoName: 'Two Finger', teams: _teams);
}
