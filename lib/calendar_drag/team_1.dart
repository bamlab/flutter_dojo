import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class CalendarTeam1 extends TeamWidget {
  const CalendarTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Guillaume & Guillaume');

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(teamName)));
  }
}
