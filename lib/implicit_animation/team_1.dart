import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class ImplicitAnimationTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<ImplicitAnimationTeam1> createState() => _ImplicitAnimationTeam1State();
}

class _ImplicitAnimationTeam1State extends State<ImplicitAnimationTeam1> {
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
