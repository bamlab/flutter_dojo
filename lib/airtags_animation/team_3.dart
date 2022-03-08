import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class AirTagsAnimationTeam3 extends TeamWidget {
  const AirTagsAnimationTeam3({
    Key? key,
  }) : super(key: key, teamName: 'Vincent & GuillaumeDM');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(teamName)),
    );
  }
}
