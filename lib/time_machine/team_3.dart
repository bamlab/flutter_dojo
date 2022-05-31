import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class TimeMachineTeam3 extends TeamWidget {
  const TimeMachineTeam3({
    Key? key,
  }) : super(key: key, teamName: 'Team 3');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(teamName),
      ),
    );
  }
}
