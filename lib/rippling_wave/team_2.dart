import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class RipplingWaveTeam2 extends StatefulWidget with TeamMixin {
  final teamName = 'Team2';

  @override
  State<RipplingWaveTeam2> createState() => _RipplingWaveTeam2State();
}

class _RipplingWaveTeam2State extends State<RipplingWaveTeam2> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Container(),
    );
  }
}
