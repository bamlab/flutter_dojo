import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class AirTagsTeam3 extends TeamWidget {
  const AirTagsTeam3({
    Key? key,
  }) : super(key: key, teamName: 'Guillaume & Vincent');

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(teamName)));
  }
}
