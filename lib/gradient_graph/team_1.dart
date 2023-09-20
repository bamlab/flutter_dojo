import 'package:bam_dojo/calendar_drag%20copy/team_1.dart';
import 'package:bam_dojo/helpers/team_class.dart';
import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'package:flutter/material.dart';

import 'data/data_point.dart';

class GradientGraphTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';
  final List<DataPoint> dataPoints = getDataPoints();

  @override
  State<GradientGraphTeam1> createState() => _GradientGraphTeam1State();
}

class _GradientGraphTeam1State extends State<GradientGraphTeam1>
    with TickerProviderStateMixin {
  late List<DataPoint> dataPoints;

  late final _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  late final _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
  );

  @override
  void initState() {
    super.initState();
    final basePoints = getDataPoints();
    setState(() {
      dataPoints =
          basePoints.whereIndexed((index, element) => index % 7 == 0).toList();
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (dataPoints.isEmpty) {
      return SizedBox();
    }
    final minValue = dataPoints
        .map((e) => e.value)
        .reduce((value, element) => value < element ? value : element);
    final maxValue = dataPoints
        .map((e) => e.value)
        .reduce((value, element) => value > element ? value : element);

    final normalizedDataPoints = dataPoints
        .map((e) => DataPoint(
            date: e.date, value: (e.value - minValue) / (maxValue - minValue)))
        .toIList();

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            height: 300,
            width: double.infinity,
            child: AnimatedBuilder(
              builder: (context, _) {
                return CustomPaint(
                    painter: GraphPainter(
                        dataPoints: normalizedDataPoints,
                        progress: _animation.value));
              },
              animation: _animation,
            ),
          ),
        ),
      ),
    );
  }
}

class GraphPainter extends CustomPainter {
  const GraphPainter({required this.dataPoints, required this.progress});
  final IList<DataPoint> dataPoints;
  final double progress;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paintStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..shader = LinearGradient(
        colors: [
          Colors.deepOrange[200]!,
          Colors.deepOrange[300]!,
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final pathStroke = Path()
      ..moveTo(0, size.height - dataPoints[0].value * size.height);

    for (int i = 1; i < progress * dataPoints.length - 1; i++) {
      pathStroke.lineTo(size.width * i / (dataPoints.length - 1),
          size.height - dataPoints[i + 1].value * size.height);
    }

    canvas.drawPath(pathStroke, paintStroke);

    Paint paintShader = Paint()
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
        colors: [
          Colors.deepOrange[100]!,
          Colors.white,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final pathShader = Path()..moveTo(0, size.height);

    for (int i = 0; i < progress * dataPoints.length - 1; i++) {
      pathShader.lineTo(size.width * i / (dataPoints.length - 1),
          size.height - dataPoints[i + 1].value * size.height);
    }

    pathShader.lineTo(
        size.width *
            (dataPoints.length * progress - 2) /
            (dataPoints.length - 1),
        size.height);

    canvas.drawPath(pathShader, paintShader);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
