import 'package:bam_dojo/haptic/team_1.dart';
import 'package:bam_dojo/haptic/team_2.dart';
import 'package:bam_dojo/haptic/team_3.dart';
import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

final _teams = <TeamWidget>[
  const HapticTeam1(),
  const HapticTeam2(),
  const HapticTeam3()
];

class HapticDojo extends DojoWidget {
  HapticDojo({
    Key? key,
  }) : super(key: key, dojoName: 'Haptic', teams: _teams);
}
