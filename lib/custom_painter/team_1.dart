import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class CustomPainterTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<CustomPainterTeam1> createState() => _CustomPainterTeam1State();
}

class _CustomPainterTeam1State extends State<CustomPainterTeam1>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2000),
  )..repeat(reverse: false);

  late final _circleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.0,
        0.6,
        curve: Curves.easeOutSine,
      ),
    ),
  );

  late final _triangleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.4,
        1.0,
        curve: Curves.easeOutSine,
      ),
    ),
  );

  late final _mountainAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.8,
        1.0,
        curve: Curves.easeOutSine,
      ),
    ),
  );
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
              child: CustomPaint(
            size: Size.square(300),
            painter: MyPainter(
                mountainAnimation: _mountainAnimation,
                circleAnimation: _circleAnimation,
                triangleAnimation: _triangleAnimation),
          ))),
    );
  }
}

class MyPainter extends CustomPainter {
  final Animation<double> circleAnimation;
  final Animation<double> triangleAnimation;
  final Animation<double> mountainAnimation;

  MyPainter({
    required this.circleAnimation,
    required this.triangleAnimation,
    required this.mountainAnimation,
  }) : super(repaint: Listenable.merge([circleAnimation, triangleAnimation]));

  void drawCircle(Canvas canvas, Size size, Paint paint) {
    final angle_depart = min<double>(
            max<double>((circleAnimation.value - 0.5) * 2 * 2 * pi, 0),
            2 * pi) -
        pi / 2;
    final angle_arrivee =
        min<double>(circleAnimation.value * 2 * 2 * pi, 2 * pi) -
            angle_depart -
            pi / 2;
    canvas.drawArc(
        Rect.fromCenter(
            center: Offset(size.width / 2, size.height / 2),
            width: size.width,
            height: size.height),
        angle_depart,
        angle_arrivee,
        false,
        paint);
  }

  void drawSegment(Canvas canvas, Size size, Paint paint, Offset vertex_1,
      Offset vertex_2, double part, bool reverse) {
    if (part == 0) return;

    final start = reverse ? vertex_2 : vertex_1;

    final end = reverse
        ? Offset(
            vertex_2.dx - (vertex_2.dx - vertex_1.dx) * part,
            vertex_2.dy - (vertex_2.dy - vertex_1.dy) * part,
          )
        : Offset(
            vertex_1.dx + (vertex_2.dx - vertex_1.dx) * part,
            vertex_1.dy + (vertex_2.dy - vertex_1.dy) * part,
          );

    canvas.drawLine(start, end, paint);
  }

  void drawTriangle(Canvas canvas, Size size, Paint paint) {
    const factor = 3;
    final vertex_1 = Offset(size.width / 2, 0);
    final vertex_2 = Offset(size.width / 2 + size.width / 2 * sin(pi / factor),
        size.height / 2 + size.height / 2 * cos(pi / factor));
    final vertex_3 = Offset(size.width / 2, size.height);
    final vertex_4 = Offset(size.width / 2 - size.width / 2 * sin(pi / factor),
        size.height / 2 + size.height / 2 * cos(pi / factor));

    final vertex_5 = Offset((vertex_2.dx / 2), (vertex_4.dy / 2));
    final vertex_6 =
        Offset(size.width / 2, (vertex_4.dy / 2) + size.height / 8);
    final vertex_7 = Offset((vertex_2.dx / 2), (vertex_4.dy / 2));

    var segment_1_part = 0.0;
    var segment_2_part = 0.0;
    var segment_3_part = 0.0;

    var segment_4_part = 0.0;
    var segment_5_part = 0.0;
    var segment_6_part = 0.0;

    var segment_1 = 0.0;

    final reverse = triangleAnimation.value > 0.5;
    switch (triangleAnimation.value) {
      case < 1 / 6:
        {
          segment_1_part = triangleAnimation.value * 6;
          segment_2_part = 0;
          segment_3_part = 0;
          break;
        }
      case < 2 / 6:
        {
          segment_1_part = 1;
          segment_2_part = (triangleAnimation.value - 1 / 6) * 6;
          segment_3_part = 0;
          break;
        }
      case < 3 / 6:
        {
          segment_1_part = 1;
          segment_2_part = 1;
          segment_3_part = (triangleAnimation.value - 2 / 6) * 6;
          break;
        }

      case < 4 / 6:
        {
          segment_1_part = 1 - (triangleAnimation.value - 3 / 6) * 6;
          segment_2_part = 1;
          segment_3_part = 1;
          break;
        }
      case < 5 / 6:
        {
          segment_1_part = 0;
          segment_2_part = 1 - (triangleAnimation.value - 4 / 6) * 6;
          segment_3_part = 1;

          break;
        }
      case < 6 / 6:
        {
          segment_1_part = 0;
          segment_2_part = 0;
          segment_3_part = 1 - (triangleAnimation.value - 6 / 6) * 6;
          break;
        }
    }

    switch (mountainAnimation.value) {}

    drawSegment(
        canvas, size, paint, vertex_1, vertex_2, segment_1_part, reverse);
    drawSegment(
        canvas, size, paint, vertex_2, vertex_3, segment_2_part, reverse);
    drawSegment(
        canvas, size, paint, vertex_3, vertex_4, segment_3_part, reverse);
    drawSegment(
        canvas, size, paint, vertex_4, vertex_1, segment_4_part, reverse);
    drawSegment(
        canvas, size, paint, vertex_5, vertex_6, segment_4_part, reverse);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 20
      ..colorFilter = ColorFilter.mode(Colors.white, BlendMode.srcIn)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    drawCircle(canvas, size, paint);
    drawTriangle(canvas, size, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
