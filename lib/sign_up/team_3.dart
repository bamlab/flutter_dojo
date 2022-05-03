import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class SignUpTeam3 extends TeamWidget {
  const SignUpTeam3({
    Key? key,
  }) : super(key: key, teamName: 'Yves Rocher');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(teamName),
      ),
    );
  }
}
