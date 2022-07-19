import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class AnimatedLikesTeam3 extends TeamWidget {
  const AnimatedLikesTeam3({
    Key? key,
  }) : super(key: key, teamName: 'Team3');

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
