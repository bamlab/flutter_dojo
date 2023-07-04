import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class UselessSliderTeam2 extends StatefulWidget with TeamMixin {
  final teamName = 'Team2';

  @override
  State<UselessSliderTeam2> createState() => _UselessSliderTeam2State();
}

class _UselessSliderTeam2State extends State<UselessSliderTeam2> {
  double offsetX = 0;
  @override
  Widget build(BuildContext context) {
    return MyApp();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Touch Position'),
        ),
        body: TouchWidget(),
      ),
    );
  }
}

class TouchWidget extends StatefulWidget {
  @override
  _TouchWidgetState createState() => _TouchWidgetState();
}

class _TouchWidgetState extends State<TouchWidget> {
  List<Offset> _points = <Offset>[];

  void _updatePoints(PointerEvent event) {
    setState(() {
      _points = List.from(_points)..add(event.position);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _updatePoints,
      onPointerMove: _updatePoints,
      onPointerUp: (PointerEvent event) => _updatePoints(event),
      child: CustomPaint(
        painter: TouchPainter(points: _points),
        child: ConstrainedBox(
          constraints: BoxConstraints.tight(Size.infinite),
        ),
      ),
    );
  }
}

class TouchPainter extends CustomPainter {
  TouchPainter({this.points});

  final List<Offset>? points;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    for (final point in points ?? []) {
      canvas.drawCircle(point, 30.0, paint);
    }
  }

  @override
  bool shouldRepaint(TouchPainter oldDelegate) {
    return oldDelegate.points != points;
  }
}
