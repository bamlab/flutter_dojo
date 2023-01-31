import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class UselessSliderTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<UselessSliderTeam1> createState() => _UselessSliderTeam1State();
}

class _UselessSliderTeam1State extends State<UselessSliderTeam1> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(),
    );
  }
}
