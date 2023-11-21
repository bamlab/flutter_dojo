import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class HeroAnimationsTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<HeroAnimationsTeam3> createState() => _HeroAnimationsTeam3State();
}

class _HeroAnimationsTeam3State extends State<HeroAnimationsTeam3> {
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