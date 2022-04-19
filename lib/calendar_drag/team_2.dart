import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class CalendarTeam2 extends TeamWidget {
  const CalendarTeam2({
    Key? key,
  }) : super(key: key, teamName: 'Guillaume Matthieu');

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(teamName)));
  }
}
