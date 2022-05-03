import 'package:bam_dojo/helpers/team_class.dart';
import 'package:bam_dojo/sign_up/team_1.dart';
import 'package:bam_dojo/sign_up/team_2.dart';
import 'package:bam_dojo/sign_up/team_3.dart';
import 'package:flutter/material.dart';

final _teams = <TeamWidget>[
  const SignUpTeam1(),
  const SignUpTeam2(),
  const SignUpTeam3()
];

class DojoSignUp extends DojoWidget {
  DojoSignUp({
    Key? key,
  }) : super(key: key, dojoName: 'SignUp ', teams: _teams);
}
