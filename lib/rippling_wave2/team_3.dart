import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class RipplingWaveTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<RipplingWaveTeam3> createState() => _RipplingWaveTeam3State();
}

class _RipplingWaveTeam3State extends State<RipplingWaveTeam3> {
  final columnCount = 30;
  final rowCount = 50;

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
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                final coordinates = indexToCoordinates(index);
                print("==> x: ${coordinates.first}, y:${coordinates.last}");
              },
              child: AnimatedScale(
                duration: const Duration(milliseconds: 400),
                scale: 0.7, //make this vary to see the effect
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
}
