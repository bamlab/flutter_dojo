import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class UselessSliderTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<UselessSliderTeam1> createState() => _UselessSliderTeam1State();
}

class _UselessSliderTeam1State extends State<UselessSliderTeam1> {
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
              GestureDetector(
                onHorizontalDragStart: (details) {
                  setState(() {
                    offsetX = min(max(0, details.localPosition.dx - 25),
                        MediaQuery.of(context).size.width - 130);
                  });
                },
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    offsetX = min(max(0, details.localPosition.dx - 25),
                        MediaQuery.of(context).size.width - 130);
                  });
                },
                onScaleStart: (details) {
                  setState(() {
                    offsetX = min(max(0, details.localFocalPoint.dx - 25),
                        MediaQuery.of(context).size.width - 130);
                  });
                },
                onScaleUpdate: (details) {
                  if (details.pointerCount < 2) {
                    return;
                  }
                  setState(() {
                    details.focalPointDelta.dx;
                    print(details.horizontalScale);
                    offsetX = min(
                        max(
                            0,
                            details.localFocalPoint.dx +
                                details.horizontalScale *
                                    MediaQuery.of(context).size.width -
                                130 -
                                25),
                        MediaQuery.of(context).size.width - 130);
                  });
                },
                child: Container(
                  height: 50,
                  color: Colors.grey,
                ),
              ),
              Positioned(
                left: offsetX,
                child: IgnorePointer(
                  child: Container(
                    height: 50,
                    width: 50,
                    color: Colors.red,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
