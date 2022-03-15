import 'package:bam_dojo/bank/team_1.dart';
import 'package:bam_dojo/bank/team_2.dart';
import 'package:bam_dojo/bank/team_3.dart';
import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

final _teams = <TeamWidget>[
  const BankTeam1(),
  const BankTeam2(),
  const BankTeam3()
];

class BankData {
  final color1 = const Color(0xFFa5b7e7);
  final color2 = const Color(0xFFc5d6e8);
  final color3 = const Color(0xFFd1b1c6);
  final color4 = const Color(0xFFed969e);

  final userUrl = "https://randomuser.me/api/portraits/men/75.jpg";
}

class DojoBank extends DojoWidget {
  DojoBank({
    Key? key,
  }) : super(key: key, dojoName: 'Bank', teams: _teams);
}
