import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

import 'pulsating_cubes.dart';



class PulsatingCubesTeam2 extends TeamWidget {
  const PulsatingCubesTeam2({
    Key? key,
  }) : super(key: key, teamName: 'Team2');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _Cubes(),
      ),
    );
  }
}

class _Cubes extends StatefulWidget {
  const _Cubes({Key? key}) : super(key: key);

  @override
  State<_Cubes> createState() => _CubesState();
}

class _CubesState extends State<_Cubes> with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 5000),
  );

  @override
  initState() {
    super.initState();

    _animationController.repeat(reverse: true);
    _animationController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // The radius of the virtual circle and square which contain all the cubes
    final virtualCircleRadius = _animationController.value * 250;
    final virtualRectRadius = virtualCircleRadius * cos(pi / 4);

    // Number of cubes in the row and column
    //
    // Use an impair number, otherwise the virtual circle will not be centered.
    final count = 3;

    // The indexes of the cubes in the row and column
    //
    // For example, if the count is 9, then the indexes will be:
    // (0, 0), (1, 0), (2, 0),
    // (0, 1), (1, 1), (2, 1),
    // (0, 2), (1, 2), (2, 2)
    //
    // They are used to calculate the position of the cubes.
    final indexes = List.generate(
      count * count,
          (index) => IntOffset(index % count, index ~/ count),
    );

    // The width and height of the cubes
    const rectSize = 50.0;

    // Summary of the previous variables with count=9:
    //
    //    rectSize
    //    ◄─────►
    //   ┌─────────────────────┐
    //   │┌─────┐┌─────┐┌─────┐│
    //   ││     ││     ││     ││
    //   │└─────┘└─────┘└─────┘│
    //   │┌─────┐┌─────┐┌─────┐│
    //   ││     ││     ││     ││
    //   │└─────┘└─────┘└─────┘│
    //   │┌─────┐┌─────┐┌─────┐│
    //   ││     ││     ││     ││
    //   │└─────┘└─────┘└─────┘│
    //   └─────────────────────┘
    //    ◄────────────────────►
    //      virtualRectRadius

    return LayoutBuilder(builder: (context, constraints) {
      final screenMiddlePosition = IntOffset(
        constraints.maxWidth ~/ 2,
        constraints.maxHeight ~/ 2,
      );
      final middleRectTop = screenMiddlePosition.y - rectSize / 2;
      final middleRectLeft = screenMiddlePosition.x - rectSize / 2;

      return Stack(
        children: indexes
            .map(
              (index) => _Cube(
            position: Offset(
              middleRectLeft + (index.x - count ~/ 2) * virtualRectRadius,
              middleRectTop + (index.y - count ~/ 2) * virtualRectRadius,
            ),
            size: rectSize,
          ),
        )
            .toList(),
      );
    });
  }
}

class _Cube extends StatelessWidget {
  const _Cube({
    Key? key,
    required this.position,
    required this.size,
  }) : super(key: key);

  final Offset position;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Container(
        width: size,
        height: size,
        // a random color
        color: Colors.redAccent,
      ),
    );
  }
}
