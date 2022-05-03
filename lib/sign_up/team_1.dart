import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class SignUpTeam1 extends TeamWidget {
  const SignUpTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Guillaumes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(teamName),
      ),
    );
  }
}
