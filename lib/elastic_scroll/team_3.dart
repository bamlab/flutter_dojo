import 'package:bam_dojo/elastic_scroll/elastic_scroll.dart';
import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class ElasticScrollTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<ElasticScrollTeam3> createState() => _ElasticScrollTeam3State();
}

class _ElasticScrollTeam3State extends State<ElasticScrollTeam3> {
  @override
  Widget build(BuildContext context) {
    return MainPage();
  }
}
