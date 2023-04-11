import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

import 'dart:ui' as ui;

class RefreshPlusTeam1 extends TeamWidget {
  const RefreshPlusTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Team1');

  @override
  Widget build(BuildContext context) {
    return _AnimatedCircles();
  }
}

class _AnimatedCircles extends StatefulWidget {
  @override
  _AnimatedCirclesState createState() => _AnimatedCirclesState();
}

class _AnimatedCirclesState extends State<_AnimatedCircles>
    with SingleTickerProviderStateMixin {
  bool animate = false;
  late AnimationController _controller;

  var touchPoint = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this)
          ..repeat(reverse: true);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          height: 400,
          width: 400,
          child: ColorFiltered(
            colorFilter: ColorFilter.matrix(
              [
                1, 0, 0, 0, 0, //
                0, 1, 0, 0, 0, //
                0, 0, 1, 0, 0, //
                0, 0, 0, 255, 0, //
              ],
            ),
            child: ColorFiltered(
              colorFilter: ColorFilter.matrix(
                [
                  1, 0, 0, 0, 0, //
                  0, 1, 0, 0, 0, //
                  0, 0, 1, 0, 0, //
                  0, 0, 0, 1, -255 / 2, //
                ],
              ),
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    touchPoint = details.localPosition;
                  });
                },
                child: CustomPaint(
                  painter: AnimatedCirclesPainter(touchPoint),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedCirclesPainter extends CustomPainter {
  final Offset position;

  AnimatedCirclesPainter(this.position);

  @override
  void paint(Canvas canvas, Size size) {
    // Create a paint for the circles
    final paint = Paint()..color = Colors.black;
    // paint.shader = shader;

    // Create a rect to use as a clip rect for the blur
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Add a gaussian blur filter
    final blurFilter = ui.ImageFilter.blur(sigmaX: 15, sigmaY: 15);
    canvas.saveLayer(rect, Paint()..imageFilter = blurFilter);

    // Draw the circles in a layer
    canvas.saveLayer(rect, Paint());
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 8,
      paint,
    );
    canvas.drawCircle(
      position,
      size.width / 8,
      paint,
    );

    // Restore the layers
    canvas.restore();
    canvas.restore();
    // canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
