import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

import 'loading_indicator.dart';

class LoadingIndicatorTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<LoadingIndicatorTeam1> createState() => _LoadingIndicatorTeam1State();
}

class _LoadingIndicatorTeam1State extends State<LoadingIndicatorTeam1> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            GradientCircle(
              color1: g1c1,
              color2: g1c2,
              diameter: 100,
            ),
            GradientCircle(
              color1: g2c1,
              color2: g2c2,
              diameter: 100,
            ),
            GradientCircle(
              color1: g3c1,
              color2: g3c2,
              diameter: 100,
            ),
          ],
        ),
      ),
    );
  }
}

class GradientCircle extends StatelessWidget {
  final Color color1;
  final Color color2;

  final Tween<Offset> tween1 = Tween(
    begin: Offset(0, -30),
    end: Offset(-30, 30),
  );

  final Tween<Offset> tween2 = Tween(
    begin: Offset(-30, 30),
    end: Offset(30, 30),
  );

  final Tween<Offset> tween3 = Tween(
    begin: Offset(30, 30),
    end: Offset(0, -30),
  );

  final double diameter;

  GradientCircle({
    super.key,
    required this.color1,
    required this.color2,
    required this.diameter,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        duration: Duration(seconds: 1),
        tween: tween2,
        builder: (context, off2, child) {
          return TweenAnimationBuilder(
            duration: Duration(seconds: 1),
            tween: tween1,
            builder: (context, off1, child) {
              return Transform.translate(
                offset: off1,
                child: child,
              );
            },
            child: Container(
              height: diameter,
              width: diameter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(diameter / 2),
                gradient: LinearGradient(
                  colors: [
                    color1,
                    color2,
                  ],
                ),
              ),
            ),
          );
        });
  }
}
