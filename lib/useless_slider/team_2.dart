import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class UselessSliderTeam2 extends StatefulWidget with TeamMixin {
  final teamName = 'Team2';

  @override
  State<UselessSliderTeam2> createState() => _UselessSliderTeam2State();
}

class _UselessSliderTeam2State extends State<UselessSliderTeam2> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(),
    );
  }
}
