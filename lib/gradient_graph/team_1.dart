import 'package:bam_dojo/calendar_drag%20copy/team_1.dart';
import 'package:bam_dojo/helpers/team_class.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'package:flutter/material.dart';

import 'data/data_point.dart';

class GradientGraphTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';
  final List<DataPoint> dataPoints = getDataPoints();

  @override
  State<GradientGraphTeam1> createState() => _GradientGraphTeam1State();
}

class _GradientGraphTeam1State extends State<GradientGraphTeam1> {
  late List<DataPoint> dataPoints;
  @override
  void initState() {
    super.initState();
    setState(() {
      dataPoints = getDataPoints();
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
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              height: 300,
              width: dataPoints.length.toDouble() * 5,
              child: CustomPaint(
                  painter: GraphPainter(dataPoints: normalizedDataPoints)),
            ),
          ),
        ),
      ),
    );
  }
}

class GraphPainter extends CustomPainter {
  const GraphPainter({required this.dataPoints});
  final IList<DataPoint> dataPoints;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paintStroke = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 6
        // ..strokeCap = StrokeCap.round;
        ;
    paintStroke.shader = LinearGradient(
      colors: [
        Colors.deepOrange[200]!,
        Colors.deepOrange[300]!,
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    Paint paintShader = Paint()..style = PaintingStyle.fill;
    paintShader.shader = LinearGradient(
      colors: [
        Colors.deepOrange[100]!,
        Colors.white,
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final pathShader = Path()..moveTo(0, size.height);

    for (int i = 0; i < dataPoints.length - 1; i++) {
      final point = Offset(i * size.width / (dataPoints.length - 2),
          size.height - dataPoints[i].value * size.height);
      final point2 = Offset((i + 1) * size.width / (dataPoints.length - 2),
          size.height - dataPoints[i + 1].value * size.height);

      final double xc = (point.dx + point2.dx) / 2;
      final double yc = (point.dy + point2.dy) / 2;
      pathShader.quadraticBezierTo(
        point.dx,
        point.dy,
        xc,
        yc,
      );
    }

    pathShader.lineTo(size.width, size.height);

    canvas.drawPath(pathShader, paintShader);
    final pathStroke = Path()
      ..moveTo(0, size.height - dataPoints[0].value * size.height);

    for (int i = 0; i < dataPoints.length - 1; i++) {
      final point = Offset(i * size.width / (dataPoints.length - 2),
          size.height - dataPoints[i].value * size.height);
      final point2 = Offset((i + 1) * size.width / (dataPoints.length - 2),
          size.height - dataPoints[i + 1].value * size.height);

      final double xc = (point.dx + point2.dx) / 2;
      final double yc = (point.dy + point2.dy) / 2;
      pathStroke.quadraticBezierTo(
        point.dx,
        point.dy,
        xc,
        yc,
      );
    }

    canvas.drawPath(pathStroke, paintStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
