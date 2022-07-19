import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class AnimatedLikesTeam1 extends TeamWidget {
  const AnimatedLikesTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Team1');

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: _AnimatedHeart(),
      ),
    );
  }
}

class _AnimatedHeart extends StatefulWidget {
  _AnimatedHeart({
    Key? key,
  }) : super(key: key);

  final screenSize = Size(100, 100);

  @override
  State<_AnimatedHeart> createState() => _AnimatedHeartState();
}

class _AnimatedHeartState extends State<_AnimatedHeart>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  final particleSystem = <Particle>[];

  @override
  void initState() {
    super.initState();

    //Generate particles
    new List.generate(1, (i) {
      particleSystem.add(new Particle(widget.screenSize));
    });

    animationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 1000))
      ..addListener(() {
        for (int i = 0; i < particleSystem.length; i++) {
          // Move particle
          particleSystem[i].move();

          // Restored particle
          if (particleSystem[i].remainingLife < 0 ||
              particleSystem[i].radius < 0) {
            particleSystem[i] = new Particle(widget.screenSize);
          }
        }
      })
      ..repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) => CustomPaint(
          size: Size(200, 200),
          painter: _DemoPainter(Size(200, 200), [Particle(Size(200, 200))]),
          child: Icon(
            Icons.favorite,
            color: Color(0xFFFD5588),
            size: 100,
          ),
        ),
      ),
    );
  }
}

class _DemoPainter extends CustomPainter {
  final List<Particle> particleSystem;
  final Size screenSize;

  _DemoPainter(this.screenSize, this.particleSystem);

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particleSystem) {
      particle.display(canvas);
    }
  }

  @override
  bool shouldRepaint(_DemoPainter oldDelegate) => true;
}

class Particle {
  late Offset speed;
  late Offset location;
  late double radius;
  late double life;
  late Color color;
  late double opacity;

  late double remainingLife;
  late Size screenSize;
  var palette = <Color>[];

  Particle(this.screenSize) {
    Random rd = new Random();

    this.speed =
        new Offset(-5 + rd.nextDouble() * 10, -15.0 + rd.nextDouble() * 10);
    this.location =
        new Offset(this.screenSize.width / 2, this.screenSize.height / 3 * 2);
    this.radius = 10 + rd.nextDouble() * 20;
    this.life = 20 + rd.nextDouble() * 10;
    this.remainingLife = this.life;

    for (int i = 30; i < 100; i++) {
      palette.add(HSLColor.fromAHSL(1.0, 0.0, 1.0, i / 100).toColor());
    }

    this.color = palette[0];
  }

  move() {
    this.remainingLife--;
    this.radius--;
    this.location = this.location + this.speed;
    int colorI = palette.length -
        (this.remainingLife / this.life * palette.length).round();
    if (colorI >= 0 && colorI < palette.length) {
      this.color = palette[colorI];
    }
  }

  display(Canvas canvas) {
    this.opacity = (this.remainingLife / this.life * 100).round() / 100;
    var gradient = new RadialGradient(
      colors: [
        Color.fromRGBO(
            this.color.red, this.color.green, this.color.blue, this.opacity),
        Color.fromRGBO(
            this.color.red, this.color.green, this.color.blue, this.opacity),
        Color.fromRGBO(this.color.red, this.color.green, this.color.blue, 0.0)
      ],
      stops: [0.0, 0.5, 1.0],
    );

    Paint painter = new Paint()
      ..style = PaintingStyle.fill
      ..shader = gradient.createShader(
          Rect.fromCircle(center: this.location, radius: this.radius));

    canvas.drawCircle(this.location, this.radius, painter);
  }
}
