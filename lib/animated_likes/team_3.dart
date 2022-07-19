import 'dart:async';
import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class AnimatedLikesTeam3 extends TeamWidget {
  const AnimatedLikesTeam3({
    Key? key,
  }) : super(key: key, teamName: 'Team3');

  @override
  Widget build(BuildContext context) {
    return Material(
      child: _AnimatedIcon(),
    );
  }
}

class _AnimatedIcon extends StatefulWidget {
  const _AnimatedIcon({Key? key}) : super(key: key);

  @override
  State<_AnimatedIcon> createState() => __AnimatedIconState();
}

class __AnimatedIconState extends State<_AnimatedIcon> {
  int plusOrMinusX = 1;
  var continueTimer = true;

  @override
  void initState() {
    super.initState();
    animateOnX();
  }

  Future<void> animateOnX() async {
    final duration = Duration(milliseconds: (100 + Random().nextInt(100)));
    while (continueTimer) {
      await Future.delayed(duration);
      setState(() {
        plusOrMinusX = plusOrMinusX * -1;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    continueTimer = false;
  }

  // Random number between -pi/4 and pi/4
  final originAngle = 2 * pi / 4 * Random().nextDouble() - pi / 4;

  @override
  Widget build(BuildContext context) {
    final size = 100.0;

    return Transform.rotate(
      angle: originAngle,
      child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: plusOrMinusX * 0.5 * size),
          duration: Duration(milliseconds: 100),
          builder: (context, xOffset, child) {
            return TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(seconds: 1),
              builder: (context, value, child) {
                final yOffset = Tween(begin: 0.0, end: -2 * size).evaluate(
                  AlwaysStoppedAnimation(value),
                );

                return Transform.translate(
                  offset: Offset(xOffset, yOffset),
                  child: Icon(
                    Icons.favorite,
                    color: Color(0xFFFD5588),
                    size: size,
                  ),
                );
              },
            );
          }),
    );
  }
}
