import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

import 'animated_button.dart';

class AnimatedButtonTeam1 extends TeamWidget {
  const AnimatedButtonTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Team1');

  @override
  Widget build(BuildContext context) {
    return AnimatedButtonStyleProvider(
      child: Material(
        child: Center(
          child: ElevatedButton(
            onPressed: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                DojoAnimatedButton.appleIcon,
                const SizedBox(width: 8),
                Text('Download for mac'),
                const SizedBox(width: 8),
                Icon(Icons.arrow_forward_rounded),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
