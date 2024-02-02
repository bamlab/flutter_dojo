import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class AnimatedCircleTeam4 extends StatefulWidget with TeamMixin {
  final teamName = 'Team4';

  @override
  State<AnimatedCircleTeam4> createState() => _AnimatedCircleTeam4State();
}

class _AnimatedCircleTeam4State extends State<AnimatedCircleTeam4>
    with TickerProviderStateMixin {
  var index = 0;
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  );

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
  void didChangeDependencies() {
    _controller.animateTo(1);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final value = 60;
    return Scaffold(
      appBar: AppBar(
        title: Text('Steps'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Center(
                child: StatsCircleRecap(
              value: value,
              animation: _animation,
              size: 150,
            )),
          ),
          SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: LastWeekInfos(animation: _animation),
          ),
        ],
      ),
    );
  }
}

class LastWeekInfos extends StatelessWidget {
  const LastWeekInfos({super.key, required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Last 7 days',
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ProgressBar(animation: animation, percent: 95, number: 900),
            ProgressBar(animation: animation, percent: 80, number: 800),
            ProgressBar(animation: animation, percent: 35, number: 700),
            ProgressBar(animation: animation, percent: 55, number: 600),
            ProgressBar(animation: animation, percent: 75, number: 500),
            ProgressBar(animation: animation, percent: 100, number: 400),
            ProgressBar(animation: animation, percent: 20, number: 300),
          ],
        )
      ],
    );
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar(
      {super.key,
      this.number = 10222,
      required this.animation,
      required this.percent});

  final Animation<double> animation;
  final double percent;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: CustomPaint(
            painter: BarPainter(
              percent: percent,
              color: Color.fromARGB(255, 47, 124, 239),
              animation: animation,
            ),
            size: Size(10, 150),
          ),
        ),
        Center(child: Text(number.toString())),
      ],
    );
  }
}

class StatsCircleRecap extends StatelessWidget {
  const StatsCircleRecap({
    super.key,
    this.size = 100,
    required this.value,
    required Animation<double> animation,
  }) : _animation = animation;

  final double size;
  final int value;
  final Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedText(value: value, animation: _animation),
          CustomPaint(
            painter: CirclePainter(
                value: value.toDouble(),
                color: Color.fromARGB(255, 47, 124, 239),
                animation: _animation),
            size: Size.square(size),
          ),
        ],
      ),
    );
  }
}

class AnimatedText extends StatelessWidget {
  const AnimatedText({super.key, required this.value, required this.animation});

  final Animation<double> animation;
  final int value;

  @override
  Widget build(BuildContext context) {
    final content = AnimatedBuilder(
        animation: animation,
        builder: (context, child) => Text(
              (value * (animation.value * 100).round() / 100)
                      .round()
                      .toString() +
                  '%',
              textScaler: TextScaler.linear(2),
            ));
    return content;
  }
}

class CirclePainter extends CustomPainter {
  final Color color;
  final Animation<double> animation;
  final double value;

  CirclePainter(
      {required this.animation, required this.color, required this.value})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..shader = LinearGradient(
        colors: [
          color.withOpacity(1),
          color.withOpacity(0.2),
          color.withOpacity(0.5),
          color.withOpacity(0.8),
        ],
        // stops: [0.1, 0.3, 0.5, 1],
      ).createShader(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2), radius: size.width))
      ..strokeWidth = 20
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final paintWithOpacity = Paint()
      ..color = color.withOpacity(0.2)
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
        Rect.fromCenter(
            center: Offset(size.width / 2, size.height / 2),
            width: size.width,
            height: size.height),
        -pi / 2,
        value * pi * 2 / 100 * animation.value,
        false,
        paint);

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2,
        paintWithOpacity);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class BarPainter extends CustomPainter {
  final Color color;
  final Animation<double> animation;
  final double percent;

  BarPainter({
    required this.animation,
    required this.color,
    required this.percent,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 10
      ..shader = LinearGradient(
        colors: [
          color.withOpacity(0.5),
          color.withOpacity(0.2),
          color.withOpacity(0.8),
          color.withOpacity(1),
        ],
        begin: Alignment.topCenter,
      ).createShader(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2), radius: size.height))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final paintWithOpacity = Paint()
      ..color = color.withOpacity(0.2)
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(size.width / 2, 0),
        Offset(size.width / 2, size.height), paintWithOpacity);


    canvas.drawLine(
        Offset(size.width / 2, size.height),
        Offset(size.width / 2,
            size.height * (1 - animation.value * percent / 100)),
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
