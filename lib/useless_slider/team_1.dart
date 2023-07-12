import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class UselessSliderTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<UselessSliderTeam1> createState() => _UselessSliderTeam1State();
}

class _UselessSliderTeam1State extends State<UselessSliderTeam1> {
  final Map<int, double?> xMap = {0: 0, 1: null};

  final Map<int, int?> gesturesIdsMap = {0: null, 1: null};

  bool isGapTooClose = true;
  bool squareSplitted = false;
  double gap = 1;
  double? focalPointX;

  bool get isGapInSplitAnimationRange => !(gap <= 1 || gap > 2);
  bool get shouldStretch => isGapInSplitAnimationRange && !squareSplitted;

  double get firstSquareWidth => shouldStretch ? 50 * gap : 50;
  double get firstSquareHeight => shouldStretch ? 50 / gap : 50;

  void onOneFingerMove(PointerMoveEvent event) {
    setState(() {
      final id = event.pointer;
      final number = gesturesIdsMap.entries
          .firstWhere(
            (element) => element.value == id,
            orElse: () => MapEntry(-1, -1),
          )
          .key;

      if (number == -1) return;

      xMap[number] = min(max(0, event.localPosition.dx),
          MediaQuery.of(context).size.width - 130);
    });
  }

  void onTwoFingersMove(PointerMoveEvent event) {
    setState(() {
      final id = event.pointer;
      final number = gesturesIdsMap.entries
          .firstWhere(
            (element) => element.value == id,
            orElse: () => MapEntry(-1, -1),
          )
          .key;

      if (number == -1) return;

      if (!isGapTooClose) {
        squareSplitted = true;
      }

      final double position = min(max(0, event.localPosition.dx),
          MediaQuery.of(context).size.width - 130);

      xMap[number] = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onScaleUpdate: (details) {
                  isGapTooClose = details.horizontalScale < 2;
                  gap = details.horizontalScale;
                  focalPointX = details.localFocalPoint.dx;
                },
                onScaleEnd: (details) {
                  gap = 1;
                  focalPointX = null;
                },
                behavior: HitTestBehavior.translucent,
                child: Listener(
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
                    if (gesturesIdsMap.values.none((value) => value == null)) {
                      onTwoFingersMove(event);
                      return;
                    }
                    onOneFingerMove(event);
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
              ),
              CenterPositionedSquare(
                  centerX: !squareSplitted && focalPointX != null
                      ? focalPointX!
                      : xMap[0]!,
                  height: firstSquareHeight,
                  width: firstSquareWidth),
              if (xMap[1] != null && squareSplitted)
                CenterPositionedSquare(
                  centerX: xMap[1]!,
                  height: 50,
                  width: 50,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class CenterPositionedSquare extends StatelessWidget {
  const CenterPositionedSquare({
    super.key,
    required this.centerX,
    required this.height,
    required this.width,
  });

  final double centerX;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: centerX - width / 2,
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.red,
          ),
          height: height,
          width: width,
        ),
      ),
    );
  }
}
