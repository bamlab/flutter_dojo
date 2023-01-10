import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

// Design: https://twitter.com/philipcdavis/status/1550133881168269312

final _teams = <TeamMixin>[
  const AnimatedButtonTeam1(),
  const AnimatedButtonTeam2(),
  const AnimatedButtonTeam3(),
];

class DojoAnimatedButton extends DojoWidget {
  DojoAnimatedButton({
    Key? key,
  }) : super(key: key, dojoName: 'AnimatedButton', teams: _teams);

  static final appleIcon =                 Image.asset(
    'assets/images/apple_logo.webp',
    color: Colors.white,
    width: 24,
    height: 24,
  );
}

class AnimatedButtonStyleProvider extends StatelessWidget {
  const AnimatedButtonStyleProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ),
      child: child,
    );
  }
}
