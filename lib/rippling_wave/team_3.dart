import 'dart:async';
import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class RipplingWaveTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<RipplingWaveTeam3> createState() => _RipplingWaveTeam3State();
}

class _RipplingWaveTeam3State extends State<RipplingWaveTeam3> {
  Timer? _timer;
  int time = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      setState(() {
        time++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 20, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (_, index) => Transform.scale(
          scale: simpleCircularWavePropagation(index % 20, index ~/ 20, time)
              .toDouble(),
          child: DecoratedBox(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == 20 ? Colors.white : Colors.red),
          ),
        ),
      ),
    );
  }
}

int simpleCircularWavePropagation(int x, int y, int t) {
  return max(2 * cos(t - x).toInt(), 1);
}
