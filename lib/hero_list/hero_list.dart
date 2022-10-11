import 'package:bam_dojo/hero_list/team_1.dart';
import 'package:bam_dojo/hero_list/team_2.dart';
import 'package:bam_dojo/hero_list/team_3.dart';
import 'package:flutter/material.dart';

import '../helpers/team_class.dart';

/// Design: https://twitter.com/EthanLipnik/status/1577094771717603328?s=20&t=5IAcUe_Xwq4tgKVJMQNIiQ

final _teams = <TeamMixin>[
  HeroListTeam1(),
  HeroListTeam2(),
  HeroListTeam3(),
];

class DojoHeroList extends DojoWidget {
  DojoHeroList({
    Key? key,
  }) : super(key: key, dojoName: 'HeroList', teams: _teams);
}
