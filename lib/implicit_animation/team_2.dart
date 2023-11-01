import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class ImplicitAnimationTeam2 extends StatefulWidget with TeamMixin {
  final teamName = 'Team2';

  @override
  State<ImplicitAnimationTeam2> createState() => _ImplicitAnimationTeam2State();
}

class _ImplicitAnimationTeam2State extends State<ImplicitAnimationTeam2>
    with TickerProviderStateMixin {
  double opacity = 0;
  double scale = 1;
  double turns = 0;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  late final Animation<double> _blink = CurvedAnimation(
    parent: _controller,
    curve: Curves.bounceIn,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: () => setState(() {
              opacity = 1 - opacity;
              scale = scale == 1 ? 2 : 1;
              turns = 1 - turns;
              opacity == 1 ? _controller.repeat() : _controller.reverse();
            }),
            child: RotationTransition(
              turns: _animation,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 500),
                scale: scale,
                child: Stack(
                  children: [
                    FadeTransition(
                      opacity: _blink,
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 64,
                      ),
                    ),
                    Icon(
                      Icons.favorite_border_outlined,
                      color: Colors.grey,
                      size: 64,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
