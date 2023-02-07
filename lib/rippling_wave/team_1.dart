import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class RipplingWaveTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<RipplingWaveTeam1> createState() => _RipplingWaveTeam1State();
}

class _RipplingWaveTeam1State extends State<RipplingWaveTeam1> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(),
    );
  }
}
