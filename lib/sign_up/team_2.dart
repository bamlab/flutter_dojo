import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class SignUpTeam2 extends TeamWidget {
  const SignUpTeam2({
    Key? key,
  }) : super(key: key, teamName: 'Pas Guillaume');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(teamName),
      ),
    );
  }
}
