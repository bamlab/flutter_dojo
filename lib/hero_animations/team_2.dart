import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class HeroAnimationsTeam2 extends StatefulWidget with TeamMixin {
  final teamName = 'Team2';

  @override
  State<HeroAnimationsTeam2> createState() => _HeroAnimationsTeam2State();
}

class _HeroAnimationsTeam2State extends State<HeroAnimationsTeam2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            width: 100,
            height: 100,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}