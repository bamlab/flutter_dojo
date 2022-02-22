import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class SurfTeam2 extends TeamWidget {
  const SurfTeam2({
    Key? key,
  }) : super(key: key, teamName: 'Matthieu & Valentin');

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Team 2')),
    );
  }
}
