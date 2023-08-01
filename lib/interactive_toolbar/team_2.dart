import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class InteractiveToolbarTeam2 extends StatefulWidget with TeamMixin {
  final teamName = 'Team2';

  @override
  State<InteractiveToolbarTeam2> createState() =>
      _InteractiveToolbarTeam2State();
}

class _InteractiveToolbarTeam2State extends State<InteractiveToolbarTeam2> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: _ToolbarItem(),
    );
  }
}

class _ToolbarItem extends StatelessWidget {
  const _ToolbarItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: randomColor(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(
          'https://avatars.dicebear.com/api/adventurer/${Random().nextInt(1000)}.png',
        ),
      ),
    );
  }
}

Color randomColor() => HSLColor.fromAHSL(
      1,
      Random().nextDouble() * 360,
      0.7,
      0.5,
    ).toColor();
