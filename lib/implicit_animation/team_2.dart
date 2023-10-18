import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class ImplicitAnimationTeam2 extends StatefulWidget with TeamMixin {
  final teamName = 'Team2';

  @override
  State<ImplicitAnimationTeam2> createState() => _ImplicitAnimationTeam2State();
}

class _ImplicitAnimationTeam2State extends State<ImplicitAnimationTeam2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Icon(
            Icons.favorite_border_outlined,
            color: Colors.grey,
            size: 64,
          ),
        ),
      ),
    );
  }
}
