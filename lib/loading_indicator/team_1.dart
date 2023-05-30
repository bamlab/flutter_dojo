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
        child: GradientCircle(
          color1: g1c1,
          color2: g1c2,
          diameter: 200,
        ),
      ),
    );
  }
}

class GradientCircle extends StatelessWidget {
  final Color color1;
  final Color color2;

  final double diameter;

  const GradientCircle({
    super.key,
    required this.color1,
    required this.color2,
    required this.diameter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
