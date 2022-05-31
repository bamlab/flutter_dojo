import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

final _teams = <TeamWidget>[
  const TimeMachineTeam1(),
  const TimeMachineTeam2(),
  const TimeMachineTeam3()
];

// Design: https://twitter.com/philipcdavis/status/1529115646495035392?s=20&t=ZUtuZ3P6iFczF9PFApHSZg
// Help tech: https://api.flutter.dev/flutter/widgets/Flow-class.html

class DojoTimeMachine extends DojoWidget {
  DojoTimeMachine({
    Key? key,
  }) : super(key: key, dojoName: 'TimeMachine', teams: _teams);
}
