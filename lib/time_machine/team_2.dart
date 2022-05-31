import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class TimeMachineTeam2 extends TeamWidget {
  const TimeMachineTeam2({
    Key? key,
  }) : super(key: key, teamName: 'Team 2');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(teamName),
      ),
    );
  }
}
