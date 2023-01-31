import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class UselessSliderTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<UselessSliderTeam3> createState() => _UselessSliderTeam3State();
}

class _UselessSliderTeam3State extends State<UselessSliderTeam3> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: GestureDetector(
          onScaleStart: (_) => print('coucou'),
          child: Container(color: Colors.white, height: 100, width: 100)),
    );
  }
}
