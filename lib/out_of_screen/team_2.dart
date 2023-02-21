import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

import 'out_of_screen.dart';

class OutOfScreenTeam2 extends TeamWidget {
  const OutOfScreenTeam2({
    Key? key,
  }) : super(key: key, teamName: 'Team2');

  @override
  Widget build(BuildContext context) {
    // Use https://docs.flutter.dev/cookbook/animation/physics-simulation
    return AvatarLinkProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Material(
          child: SafeArea(
            child: DojoOutOfScreen.basicScreen(),
          ),
        ),
      ),
    );
  }
}
