import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

import 'out_of_screen.dart';

class OutOfScreenTeam3 extends TeamWidget {
  const OutOfScreenTeam3({
    Key? key,
  }) : super(key: key, teamName: 'Team3');

  @override
  Widget build(BuildContext context) {
    return AvatarLinkProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Material(
          child: SafeArea(
            // Try DojoOutOfScreen.outOfScreenCard to get the card design
            child: DojoOutOfScreen.basicScreen(),
          ),
        ),
      ),
    );
  }
}