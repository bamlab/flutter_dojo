import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class RipplingWaveTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<RipplingWaveTeam1> createState() => _RipplingWaveTeam1State();
}

class _RipplingWaveTeam1State extends State<RipplingWaveTeam1>
    with SingleTickerProviderStateMixin {
  final columnCount = 30;
  final rowCount = 50;
  final t0 = DateTime.now().millisecondsSinceEpoch;

  late Ticker _ticker;
  late DateTime currentTime;
  late DateTime startTime;

  @override
  void initState() {
    super.initState();
    currentTime = startTime = DateTime.now();

    _ticker = createTicker((Duration elapsed) {
      setState(() {
        currentTime = startTime.add(elapsed);
      });
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: columnCount,
        children: List.generate(
          rowCount * columnCount,
          (index) {
            final coordinates = indexToCoordinates(index);
            final x = coordinates.first;
            final y = coordinates.last;
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                print("==> x: ${coordinates.first}, y:${coordinates.last}");
              },
              child: AnimatedScale(
                duration: const Duration(milliseconds: 400),
                scale: simpleCircularWavePropagation(x, y,
                    currentTime.second), //make this vary to see the effect
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            );
          },
        ),
      )),
    );
  }

  int coordinatesToIndex(int x, int y) {
    //index of (x,y) the grid (0,0 is top left)
    return y * columnCount + x;
  }

  List<int> indexToCoordinates(int n) {
    return [n % columnCount, n ~/ columnCount];
  }

  double simpleCircularWavePropagation(int x, int y, int t) {
    return max(2 * cos(t - x), 1);
  }
}
