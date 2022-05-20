import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CardHoverTeam1 extends TeamWidget {
  const CardHoverTeam1({Key? key}) : super(teamName: 'The best', key: key);

  @override
  Widget build(BuildContext context) {
    return const _CardHover();
  }
}

class _CardHover extends StatefulWidget {
  const _CardHover({Key? key}) : super(key: key);

  @override
  State<_CardHover> createState() => _CardHoverState();
}

class _CardHoverState extends State<_CardHover> {
  late Offset _mousePositionFromCenter = Offset.zero;
  late Offset _mousePosition = Offset.zero;

  final backgroundColor = Colors.black.withOpacity(0.95);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final centerPosition = Offset(
            constraints.maxWidth / 2,
            constraints.maxHeight / 2,
          );
          return MouseRegion(
            onHover: (event) {
              setState(() {
                _mousePosition = event.position;
                _mousePositionFromCenter =
                    event.position - centerPosition;
              });
            },
            cursor: SystemMouseCursors.none,
            child: Stack(
              children: [
                Center(
                  child: RadialRainbow(
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(
                              3,
                              0,
                              0.001 *
                                  _mousePositionFromCenter.dx /
                                  constraints.maxWidth)
                          ..setEntry(
                              3,
                              1,
                              0.01 *
                                  _mousePositionFromCenter.dy /
                                  constraints.maxHeight),
                        child: Card(
                          margin: EdgeInsets.zero,
                          elevation: 20,
                          color: backgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const SizedBox(
                            width: 300,
                            height: 200,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: _mousePosition.dy - 15,
                  left: _mousePosition.dx - 15,
                  height: 30,
                  width: 30,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class RadialRainbow extends StatefulWidget {
  const RadialRainbow({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<RadialRainbow> createState() => _RadialRainbowState();
}

class _RadialRainbowState extends State<RadialRainbow> {
  final precision = 5;
  late final painters = List.generate(
    (360 * precision).floor(),
    (i) {
      final angle = i / precision;
      return RadialLinePainter(
        angle: angle,
        thickness: 4 / precision,
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                ...painters
                    .map(
                      (painter) =>
                          Positioned.fill(child: CustomPaint(painter: painter)),
                    )
                    .toList(),
              ],
            ),
          ),
        ),
        widget.child,
      ],
    );
  }
}

class RadialLinePainter extends CustomPainter {
  RadialLinePainter({
    required this.thickness,
    required this.angle,
  });

  // final Color color;
  final double thickness;
  final double angle;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width;
    final paint = Paint()
      ..strokeWidth = thickness
      // Random color
      ..color = HSVColor.fromAHSV(1, angle.toDouble(), 1, 1).toColor();

    canvas.drawLine(
      center,
      Offset(
        center.dx + radius * math.cos(angle * math.pi / 180),
        center.dy + radius * math.sin(angle * math.pi / 180),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
