import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class ClothTeam1 extends TeamWidget {
  const ClothTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Team1');

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: _Cloth(),
    );
  }
}

class _Cloth extends StatefulWidget {
  const _Cloth({Key? key}) : super(key: key);

  @override
  State<_Cloth> createState() => _ClothState();
}

class _ClothState extends State<_Cloth> {
  Offset? _touchPosition;

  @override
  Widget build(BuildContext context) {
    final xCount = 20;
    final yCount = 15;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanStart: (details) {
        setState(() {
          _touchPosition = details.globalPosition;
        });
      },
      onPanUpdate: (details) {
        setState(() {
          _touchPosition = details.globalPosition;
        });
      },
      onPanEnd: (details) {
        setState(() {
          _touchPosition = null;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: xCount,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              for (var i = 0; i < xCount * yCount; i++)
                () {
                  final x = i % xCount - xCount ~/ 2;
                  final y = i ~/ xCount - yCount ~/ 2;
                  return _AttractedCube(
                    color: getColorFromPosition(x, y),
                    attractorPosition: _touchPosition,
                  );
                }()
            ],
          ),
        ),
      ),
    );
  }

  double angleFromPos(num x, num y) {
    if (x == 0 && y == 0) {
      return 0.0;
    }

    return (atan2(y, x) + pi) / (2 * pi) * 360;
  }

  HSLColor getColorFromPosition(int x, int y) {
    final color = HSLColor.fromAHSL(
      1,
      angleFromPos(x, y),
      1,
      0.7,
    );
    return color;
  }
}

class _AttractedCube extends StatefulWidget {
  const _AttractedCube({
    Key? key,
    required this.color,
    required this.attractorPosition,
  }) : super(key: key);

  final HSLColor color;
  final Offset? attractorPosition;

  @override
  State<_AttractedCube> createState() => _AttractedCubeState();
}

class _AttractedCubeState extends State<_AttractedCube> {
  final _positionKey = GlobalKey();

  Offset? get globalPosition =>
      (_positionKey.currentContext?.findRenderObject() as RenderBox?)
          ?.localToGlobal(Offset.zero);

  Offset? get offsetDiff {
    final attractorPosition = widget.attractorPosition;
    final globalPosition = this.globalPosition;

    if (attractorPosition == null || globalPosition == null) {
      return null;
    }
    final xDiff = attractorPosition.dx - globalPosition.dx;
    final yDiff = attractorPosition.dy - globalPosition.dy;
    return Offset(xDiff, yDiff);
  }

  double? get distanceToAttractor {
    final offsetDiff = this.offsetDiff;
    if (offsetDiff == null) {
      return null;
    }
    return sqrt(offsetDiff.dx * offsetDiff.dx + offsetDiff.dy * offsetDiff.dy);
  }

  // A pulling force is applied to the cube to make it move towards the attractor.
  //
  // The pulling force is proportional to the square of the distance between the
  // cube and the attractor and is always between 0 and 1.
  //
  // 1 means strong, 0 means no attraction.
  double get pullingForce {
    final distanceToAttractor = this.distanceToAttractor;
    if (distanceToAttractor == null) {
      return 0.0;
    }

    final maxDistance = 100.0;

    final relativeDistance = distanceToAttractor / maxDistance;

    return 1 / (pow(relativeDistance, 3) + 1);
  }

  @override
  Widget build(BuildContext context) {
    final minScale = 0.5;
    return KeyedSubtree(
      key: _positionKey,
      child: Transform.scale(
        scale: minScale + (1 - pullingForce) * (1 - minScale),
        child: Transform.translate(
          offset: pullingForce == 0
              ? Offset.zero
              : Offset(
                  offsetDiff!.dx * pow(pullingForce, 2),
                  offsetDiff!.dy * pow(pullingForce, 2),
                ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: widget.color.toColor(),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
