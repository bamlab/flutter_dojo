import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class AnimatedSwitcherTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<AnimatedSwitcherTeam3> createState() => _AnimatedSwitcherTeam3State();
}

class _AnimatedSwitcherTeam3State extends State<AnimatedSwitcherTeam3> {
  Color color = Colors.red;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => setState(() {
                color = Color((Random().nextDouble() * 0xFFFFFF).toInt())
                    .withOpacity(1.0);
              }),
              child: Text('hello'),
            ),
            Center(
              child: AnimatedSwitcher(
                transitionBuilder: (child, animation) =>
                    SizeTransition(sizeFactor: animation, child: child),
                layoutBuilder: (currentChild, previousChildren) => Column(
                  children: [
                    ...previousChildren,
                    if (currentChild != null) currentChild,
                  ],
                ),
                duration: Duration(seconds: 1),
                child: Container(
                  key: ValueKey(color),
                  width: 100,
                  height: 100,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
