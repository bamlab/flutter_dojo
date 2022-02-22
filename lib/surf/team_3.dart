import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class SurfTeam3 extends TeamWidget {
  const SurfTeam3({
    Key? key,
  }) : super(key: key, teamName: 'Guillaume & Vincent');

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Team 3')),
    );
  }
}
