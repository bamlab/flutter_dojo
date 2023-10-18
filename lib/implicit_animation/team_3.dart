import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class ImplicitAnimationTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<ImplicitAnimationTeam3> createState() => _ImplicitAnimationTeam3State();
}

class _ImplicitAnimationTeam3State extends State<ImplicitAnimationTeam3> {
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
