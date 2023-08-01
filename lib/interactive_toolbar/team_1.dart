import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class InteractiveToolbarTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<InteractiveToolbarTeam1> createState() =>
      _InteractiveToolbarTeam1State();
}

class _InteractiveToolbarTeam1State extends State<InteractiveToolbarTeam1> {
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
