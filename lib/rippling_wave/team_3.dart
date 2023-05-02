import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class RipplingWaveTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<RipplingWaveTeam3> createState() => _RipplingWaveTeam3State();
}

class _RipplingWaveTeam3State extends State<RipplingWaveTeam3> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 20),
          itemBuilder: (_, __) => DecoratedBox(
                decoration: BoxDecoration(shape: BoxShape.circle),
              )),
    );
  }
}
