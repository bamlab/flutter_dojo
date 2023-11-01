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
    duration: const Duration(milliseconds: 1000),
  )..repeat(reverse: false);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
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
          body: Center(
              child: CustomPaint(
        size: Size(100, 100),
        painter: MyPainter(animation: _animation),
      ))),
    );
  }
}

class MyPainter extends CustomPainter {
  final Animation<double> animation;

  MyPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final angle_depart = min<double>(
        max<double>((animation.value - 0.25) * 2 * 2 * pi, 0), 2 * pi);
    final angle_arrivee =
        min<double>(animation.value * 2 * 2 * pi, 2 * pi) - angle_depart;

    // animation.value < 0.5 ? pi / 2 : (2 * pi )

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

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
