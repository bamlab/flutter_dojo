import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class AnimatedLikesTeam2 extends TeamWidget {
  const AnimatedLikesTeam2({
    Key? key,
  }) : super(key: key, teamName: 'Team2');

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Icon(
          Icons.favorite,
          color: Color(0xFFFD5588),
          size: 100,
        ),
      ),
    );
  }
}
