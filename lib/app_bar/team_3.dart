import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class AppBarTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<AppBarTeam3> createState() => _AppBarTeam3State();
}

class _AppBarTeam3State extends State<AppBarTeam3> {
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
