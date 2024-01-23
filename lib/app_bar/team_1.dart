import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class AppBarTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<AppBarTeam1> createState() => _AppBarTeam1State();
}

class _AppBarTeam1State extends State<AppBarTeam1> {
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
