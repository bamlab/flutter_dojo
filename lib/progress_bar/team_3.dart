import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class ProgressBarTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<ProgressBarTeam3> createState() => _ProgressBarTeam3State();
}

class _ProgressBarTeam3State extends State<ProgressBarTeam3> {
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
