import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class ElasticScrollTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<ElasticScrollTeam1> createState() => _ElasticScrollTeam1State();
}

class _ElasticScrollTeam1State extends State<ElasticScrollTeam1> {
  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}
