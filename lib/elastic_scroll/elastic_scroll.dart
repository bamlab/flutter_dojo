import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

/// Design: https://twitter.com/theShaneLevine/status/1632583470512844800?s=20

final _teams = <TeamMixin>[
  ElasticScrollTeam1(),
  ElasticScrollTeam2(),
  ElasticScrollTeam3(),
];

class DojoElasticScroll extends DojoWidget {
  DojoElasticScroll({
    Key? key,
  }) : super(key: key, dojoName: 'ElasticScroll', teams: _teams);
}
