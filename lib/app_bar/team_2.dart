import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class AppBarTeam2 extends StatefulWidget with TeamMixin {
  final teamName = 'Team2';

  @override
  State<AppBarTeam2> createState() => _AppBarTeam2State();
}

class _AppBarTeam2State extends State<AppBarTeam2> {
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
