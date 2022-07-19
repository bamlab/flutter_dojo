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
      child: _ClickableAnimatedButton(),
    );
  }
}

class _ClickableAnimatedButton extends StatefulWidget {
  const _ClickableAnimatedButton({Key? key}) : super(key: key);

  @override
  State<_ClickableAnimatedButton> createState() =>
      _ClickableAnimatedButtonState();
}

class _ClickableAnimatedButtonState extends State<_ClickableAnimatedButton> {
  final _animatedIconsKeys = <Key>[];
  final size = 100.0;
  late final icon = Icon(
    Icons.favorite,
    color: Color(0xFFFD5588),
    size: size,
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          ..._animatedIconsKeys.map(
            (key) => _AnimatedIcon(key: key, icon: icon, size: size,),
          ),
          GestureDetector(
            onTap: () async {
              setState(() {
                _animatedIconsKeys.add(UniqueKey());
              });
              await Future.delayed(Duration(seconds: 1));
              if (mounted) {
                _animatedIconsKeys.remove(UniqueKey());
              }
            },
            child: icon,
          ),
        ],
      ),
    );
  }
}

class _AnimatedIcon extends StatefulWidget {
  const _AnimatedIcon({
    Key? key,
    required this.icon,
    required this.size,
  }) : super(key: key);

  final Widget icon;
  final double size;

  @override
  State<_AnimatedIcon> createState() => _AnimatedIconState();
}

class _AnimatedIconState extends State<_AnimatedIcon> {
  int plusOrMinusX = 1;
  var continueTimer = true;

  // The final y position of the icon
  late final endYOffset = -(1.5 + Random().nextDouble()) * widget.size;

  final animationDuration = Duration(seconds: 1);

  @override
  void initState() {
    super.initState();
    animateOnX();
  }

  Future<void> animateOnX() async {
    while (continueTimer) {
      final duration = Duration(milliseconds: (100 + Random().nextInt(100)));
      await Future.delayed(duration);
      if (mounted) {
        setState(() {
          plusOrMinusX = plusOrMinusX * -1;
        });
      }
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
    return Transform.rotate(
      angle: originAngle,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: plusOrMinusX * 0.5 * widget.size),
        duration: Duration(milliseconds: 100),
        builder: (context, xOffset, child) {
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: endYOffset),
            duration: animationDuration,
            builder: (context, yOffset, child) {
              return TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: animationDuration,
                builder: (context, progress, child) {
                  final fadeStartProgress = 0.5;
                  final fadeDuration =
                      (animationDuration.inMilliseconds * fadeStartProgress)
                          .ceil();

                  return AnimatedOpacity(
                    duration: Duration(milliseconds: fadeDuration),
                    opacity: progress > fadeStartProgress ? 0 : 1,
                    child: child!,
                  );
                },
                child: Transform.translate(
                  offset: Offset(xOffset, yOffset),
                  child: Icon(
                    Icons.favorite,
                    color: Color(0xFFFD5588),
                    size: widget.size,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
