import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class RoundScrollbarTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<RoundScrollbarTeam3> createState() => _RoundScrollbarTeam3State();
}

class _RoundScrollbarTeam3State extends State<RoundScrollbarTeam3> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(),
    );
  }
}
