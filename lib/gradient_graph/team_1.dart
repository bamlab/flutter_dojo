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
          child: Container(
            height: 300,
            width: 300,
            child: CustomPaint(
                painter: GraphPainter(dataPoints: normalizedDataPoints)),
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
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final path = Path()..moveTo(0, dataPoints[0].value * size.height);
    for (int i = 1; i < dataPoints.length; i++) {
      path.lineTo(i * size.width / (dataPoints.length - 1),
          dataPoints[i].value * size.height);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
