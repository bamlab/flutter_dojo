import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class AirTagsTeam2 extends TeamWidget {
  const AirTagsTeam2({
    Key? key,
  }) : super(key: key, teamName: 'Matthieu & Valentin');

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(teamName)));
  }
}
