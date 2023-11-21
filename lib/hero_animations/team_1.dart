import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class HeroAnimationsTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<HeroAnimationsTeam1> createState() => _HeroAnimationsTeam1State();
}

class _HeroAnimationsTeam1State extends State<HeroAnimationsTeam1> {
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