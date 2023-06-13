import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

import 'loading_indicator.dart';

class LoadingIndicatorTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<LoadingIndicatorTeam1> createState() => _LoadingIndicatorTeam1State();
}

class _LoadingIndicatorTeam1State extends State<LoadingIndicatorTeam1> {
  final tweens = [
    TweenSequenceItem(
      tween: Tween(
        begin: Offset(0, -30),
        end: Offset(-30, 30),
      ),
      weight: 1 / 6,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: Offset(-30, 30),
        end: Offset(-30, 30),
      ),
      weight: 1 / 6,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: Offset(-30, 30),
        end: Offset(30, 30),
      ),
      weight: 1 / 6,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: Offset(30, 30),
        end: Offset(30, 30),
      ),
      weight: 1 / 6,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: Offset(30, 30),
        end: Offset(0, -30),
      ),
      weight: 1 / 6,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: Offset(0, -30),
        end: Offset(0, -30),
      ),
      weight: 1 / 6,
    )
  ];

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
              tweens: tweens,
            ),
            GradientCircle(
              color1: g2c1,
              color2: g2c2,
              diameter: 100,
              tweens: tweens.sublist(2) + tweens.sublist(0, 2),
            ),
            GradientCircle(
              color1: g3c1,
              color2: g3c2,
              diameter: 100,
              tweens: tweens.sublist(4) + tweens.sublist(0, 4),
            ),
          ],
        ),
      ),
    );
  }
}

class GradientCircle extends StatefulWidget {
  final Color color1;
  final Color color2;
  final List<TweenSequenceItem> tweens;

  final double diameter;

  GradientCircle({
    super.key,
    required this.color1,
    required this.color2,
    required this.diameter,
    required this.tweens,
  });

  @override
  State<GradientCircle> createState() => _GradientCircleState();
}

class _GradientCircleState extends State<GradientCircle>
    with TickerProviderStateMixin {
  late final tweenSequence = TweenSequence(widget.tweens).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ),
  );

  late final _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 2));

  @override
  void initState() {
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        child: Container(
          height: widget.diameter,
          width: widget.diameter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.diameter / 2),
            gradient: LinearGradient(
              colors: [
                widget.color1,
                widget.color2,
              ],
            ),
          ),
        ),
        builder: (context, child) {
          return Transform.translate(
            offset: tweenSequence.value,
            child: child!,
          );
        });
  }
}
