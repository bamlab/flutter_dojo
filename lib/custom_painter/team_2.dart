import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class CustomPainterTeam2 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<CustomPainterTeam2> createState() => _CustomPainterTeam2State();
}

class _CustomPainterTeam2State extends State<CustomPainterTeam2>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2750),
  )..repeat(reverse: false);

  late final _circleAnimation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.0,
        0.3,
        curve: Curves.easeInOut,
      ),
    ),
  );

  late final _circleAnimation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.3,
        0.6,
        curve: Curves.easeInOut,
      ),
    ),
  );

  late final _triangleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.52,
        1.0,
        curve: Curves.easeInOut,
      ),
    ),
  );

  late final _moutainAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.63,
        1.0,
        curve: Curves.easeInOut,
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
            size: Size.square(200),
            painter: MyPainter(
                circleAnimation2: _circleAnimation2,
                mountainAnimation: _moutainAnimation,
                circleAnimation1: _circleAnimation1,
                triangleAnimation: _triangleAnimation),
          ))),
    );
  }
}

class MyPainter extends CustomPainter {
  final Animation<double> circleAnimation1;
  final Animation<double> circleAnimation2;
  final Animation<double> triangleAnimation;
  final Animation<double> mountainAnimation;

  MyPainter({
    required this.circleAnimation1,
    required this.circleAnimation2,
    required this.triangleAnimation,
    required this.mountainAnimation,
  }) : super(repaint: Listenable.merge([circleAnimation1, triangleAnimation]));

  void drawCircle(
      Canvas canvas, Size size, Paint paint, Animation<double> animation) {
    final angle_depart = min<double>(
            max<double>((animation.value - 0.5) * 2 * 2 * pi, 0), 2 * pi) -
        pi / 2;
    final angle_arrivee = min<double>(animation.value * 2 * 2 * pi, 2 * pi) -
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
    final vertex_3 = Offset(size.width / 2 - size.width / 2 * sin(pi / factor),
        size.height / 2 + size.height / 2 * cos(pi / factor));

    final vertex_5 =
        Offset((vertex_1.dx - vertex_3.dx) / 1.5, (vertex_3.dy / 2));
    final vertex_6 =
        Offset(size.width / 2.5, (vertex_3.dy / 2) + size.height / 8);

    final vertex_7 = Offset(size.width / 2, (vertex_3.dy / 2));

    final vertex_8 = Offset(size.width / 1.5 + 4, (vertex_3.dy / 2));

    var segment_1_part = 0.0;
    var segment_2_part = 0.0;
    var segment_3_part = 0.0;

    var segment_4_part = 0.0;
    var segment_5_part = 0.0;
    var segment_6_part = 0.0;

    final reverse = triangleAnimation.value > 0.5;
    final secondeReverse = mountainAnimation.value > 0.4;
    switch (triangleAnimation.value) {
      case < 1 / 20:
        {
          segment_1_part = triangleAnimation.value * 20;
          segment_2_part = 0;
          segment_3_part = 0;
          break;
        }
      case < 2 / 20:
        {
          segment_1_part = 1;
          segment_2_part = (triangleAnimation.value - 1 / 20) * 20;
          segment_3_part = 0;
          break;
        }
      case < 3 / 20:
        {
          segment_1_part = 1;
          segment_2_part = 1;
          segment_3_part = (triangleAnimation.value - 2 / 20) * 20;
          break;
        }
      case < 17 / 20:
        {
          segment_1_part = 1;
          segment_2_part = 1;
          segment_3_part = 1;
          break;
        }
      case < 18 / 20:
        {
          segment_1_part = 1 - (triangleAnimation.value - 17 / 20) * 20;
          segment_2_part = 1;
          segment_3_part = 1;
          break;
        }
      case < 19 / 20:
        {
          segment_1_part = 0;
          segment_2_part = 1 - (triangleAnimation.value - 18 / 20) * 20;
          segment_3_part = 1;
          break;
        }
      case < 20 / 20:
        {
          segment_1_part = 0;
          segment_2_part = 0;
          segment_3_part = 1 - (triangleAnimation.value - 19 / 20) * 20;
          break;
        }
    }

    switch (mountainAnimation.value) {
      case < 1 / 20:
        {
          segment_4_part = mountainAnimation.value * 20;
          segment_5_part = 0;
          segment_6_part = 0;
          break;
        }
      case < 2 / 20:
        {
          segment_4_part = 1;
          segment_5_part = (mountainAnimation.value - 1 / 20) * 20;
          segment_6_part = 0;
          break;
        }
      case < 3 / 20:
        {
          segment_4_part = 1;
          segment_5_part = 1;
          segment_6_part = (mountainAnimation.value - 2 / 20) * 20;
          break;
        }
      case < 17 / 20:
        {
          segment_4_part = 1;
          segment_5_part = 1;
          segment_6_part = 1;
          break;
        }
      case < 18 / 20:
        {
          segment_4_part = 1 - (mountainAnimation.value - 17 / 20) * 20;
          segment_5_part = 1;
          segment_6_part = 1;
          break;
        }
      case < 19 / 20:
        {
          segment_4_part = 0;
          segment_5_part = 1 - (mountainAnimation.value - 18 / 20) * 20;
          segment_6_part = 1;
          break;
        }
      case < 20 / 20:
        {
          segment_4_part = 0;
          segment_5_part = 0;
          segment_6_part = 1 - (mountainAnimation.value - 19 / 20) * 20;
          break;
        }
    }

    drawSegment(
        canvas, size, paint, vertex_1, vertex_2, segment_1_part, reverse);
    drawSegment(
        canvas, size, paint, vertex_2, vertex_3, segment_2_part, reverse);
    drawSegment(
        canvas, size, paint, vertex_3, vertex_1, segment_3_part, reverse);
    drawSegment(canvas, size, paint, vertex_5, vertex_6, segment_4_part,
        secondeReverse);
    drawSegment(canvas, size, paint, vertex_6, vertex_7, segment_5_part,
        secondeReverse);
    drawSegment(canvas, size, paint, vertex_7, vertex_8, segment_6_part,
        secondeReverse);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 20
      ..colorFilter = ColorFilter.mode(Colors.white, BlendMode.srcIn)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    drawCircle(canvas, size, paint, circleAnimation1);
    drawCircle(canvas, size, paint, circleAnimation2);
    drawTriangle(canvas, size, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
