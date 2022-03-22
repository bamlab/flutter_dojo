import 'package:bam_dojo/bank_animation/team_1.dart';
import 'package:bam_dojo/bank_animation/team_2.dart';
import 'package:bam_dojo/bank_animation/team_3.dart';
import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

final _teams = <TeamWidget>[
  const BankAnimationTeam1(),
  const BankAnimationTeam2(),
  const BankAnimationTeam3()
];

class BankAnimationData {
  final color1 = const Color(0xFFa5b7e7);
  final color2 = const Color(0xFFc5d6e8);
  final color3 = const Color(0xFFd1b1c6);
  final color4 = const Color(0xFFed969e);

  final userUrl = "https://randomuser.me/api/portraits/men/75.jpg";
}

class DojoBankAnimation extends DojoWidget {
  DojoBankAnimation({
    Key? key,
  }) : super(key: key, dojoName: 'BankAnimation', teams: _teams);
}
