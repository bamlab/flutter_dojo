import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

import 'dart:ui' as ui;

class ImprovedCounterAppTeam1 extends TeamWidget {
  const ImprovedCounterAppTeam1({
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
  var _count = 0;

  bool animate = false;
  late final _dropAnimationController = AnimationController(
    duration: Duration(seconds: 2),
    vsync: this,
  );
  late final _dropAnimation = CurvedAnimation(
    parent: _dropAnimationController,
    curve: Curves.easeInOutQuart,
  );

  @override
  void initState() {
    super.initState();
    _dropAnimationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _dropAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 1300,
              width: 400,
              child: LayoutBuilder(builder: (context, constraints) {
                return ColorFiltered(
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
                      onTap: () async {
                        await _dropAnimationController.animateTo(0);
                        await _dropAnimationController.forward();
                      },
                      child: CustomPaint(
                        painter: AnimatedCirclesPainter(
                          centerPosition: Offset(
                            constraints.maxWidth / 2,
                            _dropAnimation.value * 465,
                          ),
                          accentColor: _dropAnimationController.status ==
                                  AnimationStatus.forward
                              ? Colors.blueAccent
                              : Colors.red,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          Center(
            child: SizedBox(
              width: 250,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () async {
                      () async {
                        await Future.delayed(Duration(milliseconds: 500));
                        setState(() {
                          _count--;
                        });
                      }();
                      await _dropAnimationController.reverse(from: 1);
                    },
                    icon: Icon(Icons.remove, size: 40),
                  ),
                  Text('$_count',
                      style: TextStyle(color: Colors.white, fontSize: 30)),
                  IconButton(
                    onPressed: () async {
                      await _dropAnimationController.forward(from: 0);
                      setState(() {
                        _count++;
                      });
                    },
                    icon: Icon(Icons.add, size: 40),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AnimatedCirclesPainter extends CustomPainter {
  AnimatedCirclesPainter({
    required this.centerPosition,
    required this.accentColor,
  });

  final Offset centerPosition;
  final Color accentColor;

  final islandTopPosition = 30.0;
  final islandSize = Size(150, 36);

  @override
  void paint(Canvas canvas, Size size) {
    // Create a rect to use as a clip rect for the blur
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Add a gaussian blur filter
    final blurFilter = ui.ImageFilter.blur(sigmaX: 15, sigmaY: 15);
    canvas.saveLayer(rect, Paint()..imageFilter = blurFilter);

    // Paint the ios dynamic island
    final islandPaint = Paint()..color = accentColor;
    final islandRect = Rect.fromCenter(
      center: Offset(size.width / 2, islandTopPosition),
      width: islandSize.width,
      height: islandSize.height,
    );
    canvas.drawOval(islandRect, islandPaint);

    // Create a new layer where everything above the dynamic island is clipped
    canvas.saveLayer(rect, Paint());

    canvas.clipRect(
      Rect.fromLTWH(0, islandTopPosition, size.width, size.height),
    );

    // Draw the circles in a layer
    canvas.saveLayer(rect, Paint());
    final circlePaint = Paint()..color = Colors.black;
    final circleSize = size.width / 8;
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      circleSize,
      circlePaint,
    );
    canvas.drawCircle(
      centerPosition,
      circleSize,
      circlePaint,
    );

    // Restore the layers
    canvas.restore();
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
