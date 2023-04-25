import 'package:bam_dojo/elastic_scroll/elastic_scroll.dart';
import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class ElasticScrollTeam2 extends StatefulWidget with TeamMixin {
  final teamName = 'Team2';

  @override
  State<ElasticScrollTeam2> createState() => _ElasticScrollTeam2State();
}

class _ElasticScrollTeam2State extends State<ElasticScrollTeam2> {
  @override
  Widget build(BuildContext context) {
    return MainPage();
  }
}
