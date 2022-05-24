import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class TwoFingersTeam2 extends TeamWidget {
  const TwoFingersTeam2({
    Key? key,
  }) : super(key: key, teamName: 'Louis & Lucas');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(teamName)),
    );
  }
}
