import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:bam_dojo/out_of_screen/out_of_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OutOfScreenTeam1 extends TeamWidget {
  const OutOfScreenTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Team1');

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
