import 'dart:async';

import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class ImplicitAnimationTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<ImplicitAnimationTeam1> createState() => _ImplicitAnimationTeam1State();
}

class _ImplicitAnimationTeam1State extends State<ImplicitAnimationTeam1> {
  double opacity = 0;
  double scale = 1;
  double turns = 0;

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
            }),
            child: AnimatedRotation(
              duration: const Duration(milliseconds: 500),
              turns: turns,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 500),
                scale: scale,
                child: Stack(
                  children: [
                    AnimatedOpacity(
                      opacity: opacity,
                      duration: const Duration(milliseconds: 500),
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
