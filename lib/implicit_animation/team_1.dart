import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class ImplicitAnimationTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<ImplicitAnimationTeam1> createState() => _ImplicitAnimationTeam1State();
}

class _ImplicitAnimationTeam1State extends State<ImplicitAnimationTeam1>
    with TickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2000),
  )..repeat(reverse: true);

  late final _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: RotationTransition(
            turns: _animation,
            child: Stack(
              children: [
                AnimatedBuilder(
                  builder: (context, child) {
                    return Opacity(
                      opacity: _animation.value > 0.5 ? 1 : 0,
                      child: child,
                    );
                  },
                  animation: _animation,
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
    );
  }
}
