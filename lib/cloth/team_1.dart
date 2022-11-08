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

class _Cloth extends StatelessWidget {
  const _Cloth({Key? key}) : super(key: key);
  final xCount = 20;
  final yCount = 15;

  double angleFromPos(num x, num y) {
    if (x == 0 && y == 0) {
      return 0.0;
    }

    return (atan2(y, x) + pi) / (2 * pi) * 360;
  }

  HSLColor getColorFromPosition(int x, int y) {
    return HSLColor.fromAHSL(1, angleFromPos(x, y), 1, 0.7);
  }

  @override
  Widget build(BuildContext context) {
    return TouchPositionBuilder(builder: (context, touchPosition) {
      return Padding(
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
                    attractorPosition: touchPosition,
                  );
                }()
            ],
          ),
        ),
      );
    });
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
  final minScale = 0.5;
  late double scale;
  late Offset offset;

  @override
  void initState() {
    super.initState();
    _setScaleAndOffset();
  }

  @override
  void didUpdateWidget(covariant _AttractedCube oldWidget) {
    super.didUpdateWidget(oldWidget);
      _setScaleAndOffset();
  }

  double offsetDist(Offset offset1, Offset offset2) {
    final xDiff = offset1.dx - offset2.dx;
    final yDiff = offset1.dy - offset2.dy;
    return sqrt(xDiff * xDiff + yDiff * yDiff);
  }

  void _setScaleAndOffset() {
    scale = minScale + (1 - pullingForce) * (1 - minScale);
    offset = pullingForce == 0 ? Offset.zero : offsetDiff! * pullingForce;
  }

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

  double get pullingForce {
    final distanceToAttractor = this.distanceToAttractor;
    if (distanceToAttractor == null) {
      return 0.0;
    }

    final maxDistance = 100.0;

    final relativeDistance = distanceToAttractor / maxDistance;

    return pow(1 / (pow(relativeDistance, 3) + 1), 2) * 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: _positionKey,
      child: Transform.scale(
        scale: scale,
        child: Transform.translate(
          offset: offset,
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

class TouchPositionBuilder extends StatefulWidget {
  const TouchPositionBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final Widget Function(BuildContext context, Offset? touchPosition) builder;

  @override
  State<TouchPositionBuilder> createState() => _TouchPositionBuilderState();
}

class _TouchPositionBuilderState extends State<TouchPositionBuilder> {
  Offset? _touchPosition;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanStart: (details) {
        setState(() => _touchPosition = details.globalPosition);
      },
      onPanUpdate: (details) {
        setState(() => _touchPosition = details.globalPosition);
      },
      onPanEnd: (details) => setState(() => _touchPosition = null),
      child: widget.builder(context, _touchPosition),
    );
  }
}
