import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class AirTagsTeam1 extends TeamWidget {
  const AirTagsTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Louis & Lucas');

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(teamName)));
  }
}
