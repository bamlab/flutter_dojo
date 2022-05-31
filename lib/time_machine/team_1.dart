import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class TimeMachineTeam1 extends TeamWidget {
  const TimeMachineTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Team 1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(teamName),
      ),
    );
  }
}
