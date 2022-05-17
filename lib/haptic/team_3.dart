import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class HapticTeam3 extends TeamWidget {
  const HapticTeam3({
    Key? key,
  }) : super(key: key, teamName: 'Louis & Lucas');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(teamName)),
    );
  }
}
