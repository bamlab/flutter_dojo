import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class UselessSliderTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<UselessSliderTeam1> createState() => _UselessSliderTeam1State();
}

class _UselessSliderTeam1State extends State<UselessSliderTeam1> {
  final Map<int, double?> offsetMap = {0: 0, 1: null};

  final Map<int, int?> gesturesIdsMap = {0: null, 1: null};

  double offsetX = 0;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Stack(
            children: [
              Listener(
                onPointerDown: (event) {
                  setState(() {
                    if (gesturesIdsMap[0] == null) {
                      gesturesIdsMap[0] = event.pointer;
                      return;
                    }
                    if (gesturesIdsMap[1] == null)
                      gesturesIdsMap[1] = event.pointer;
                    return;
                  });
                },
                onPointerMove: (event) {
                  setState(() {
                    final id = event.pointer;
                    final number = gesturesIdsMap.entries
                        .firstWhere(
                          (element) => element.value == id,
                          orElse: () => MapEntry(-1, -1),
                        )
                        .key;

                    if (number == -1) return;

                    offsetMap[number] = min(max(0, event.localPosition.dx - 25),
                        MediaQuery.of(context).size.width - 130);
                  });
                },
                onPointerUp: (event) {
                  setState(() {
                    final id = event.pointer;
                    final number = gesturesIdsMap.entries
                        .firstWhere(
                          (element) => element.value == id,
                          orElse: () => MapEntry(-1, -1),
                        )
                        .key;

                    if (number == -1) return;

                    gesturesIdsMap[number] = null;
                  });
                },
                // onHorizontalDragStart: (details) {
                //   setState(() {
                //     offsetX = min(max(0, details.localPosition.dx - 25),
                //         MediaQuery.of(context).size.width - 130);
                //   });
                // },
                // onHorizontalDragUpdate: (details) {

                //   setState(() {
                //     offsetX = min(max(0, details.localPosition.dx - 25),
                //         MediaQuery.of(context).size.width - 130);
                //   });
                // },
                // onScaleStart: (details) {
                //   setState(() {
                //     offsetX = min(max(0, details.localFocalPoint.dx - 25),
                //         MediaQuery.of(context).size.width - 130);
                //   });
                // },
                // onScaleUpdate: (details) {
                //   if (details.pointerCount < 2) {
                //     return;
                //   }
                //   setState(() {
                //     details.focalPointDelta.dx;
                //     print(details.horizontalScale);
                //     offsetX = min(
                //         max(
                //             0,
                //             details.localFocalPoint.dx +
                //                 details.horizontalScale *
                //                     MediaQuery.of(context).size.width -
                //                 130 -
                //                 25),
                //         MediaQuery.of(context).size.width - 130);
                //   });
                // },
                child: Container(
                  height: 50,
                  color: Colors.grey,
                ),
              ),
              Positioned(
                left: offsetMap[0],
                child: IgnorePointer(
                  child: Container(
                    height: 50,
                    width: 50,
                    color: Colors.red,
                  ),
                ),
              ),
              if (offsetMap[1] != null)
                Positioned(
                  left: offsetMap[1],
                  child: IgnorePointer(
                    child: Container(
                      height: 50,
                      width: 50,
                      color: Colors.red,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
