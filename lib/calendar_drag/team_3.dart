import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class CalendarTeam3 extends TeamWidget {
  const CalendarTeam3({
    Key? key,
  }) : super(key: key, teamName: 'Louis & Matthieu');

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(teamName)));
  }
}
