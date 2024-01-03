import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class ProgressBarTeam2 extends StatefulWidget with TeamMixin {
  final teamName = 'Team2';

  @override
  State<ProgressBarTeam2> createState() => _ProgressBarTeam2State();
}

class _ProgressBarTeam2State extends State<ProgressBarTeam2> {
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
