import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class HoleCardsTeam1 extends TeamWidget {
  const HoleCardsTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Team1');

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: _CardsHandler(),
    );
  }
}

class _CardsHandler extends StatefulWidget {
  const _CardsHandler({Key? key}) : super(key: key);

  @override
  State<_CardsHandler> createState() => _CardsHandlerState();
}

class _CardsHandlerState extends State<_CardsHandler>
    with SingleTickerProviderStateMixin {
  final cardSize = 150.0;

  late final cardOffsetTween = Tween<double>(
    begin: 0,
    end: 2 * cardSize,
  );

  late final cardOffsetAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  );

  double get cardOffset {
    return cardOffsetTween.evaluate(cardOffsetAnimationController);
  }

  initState() {
    super.initState();
    cardOffsetAnimationController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: cardOffsetAnimationController.reset,
        child: const Icon(Icons.lock_reset_outlined),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: cardOffsetAnimationController.forward,
        child: Center(
          child: Stack(
            children: [
              // Rotate backwards
              for (var i = 0; i < 100; i++)
                Transform(
                  transform: Matrix4.identity()
                    ..translate(cardOffset)
                    ..rotateX(-pi / 2 + 0.2),
                  child: Transform.translate(
                    offset: Offset(-200, -i.toDouble()*cardOffsetAnimationController.value*100+1000),
                    child: CustomPaint(
                      painter: BlackHolePainter(),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Create a black hole with a grey border
class BlackHolePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      100,
      paint,
    );

    // paint
    //   ..color = Colors.black
    //   ..style = PaintingStyle.fill;
    //
    // canvas.drawCircle(
    //   Offset(size.width / 2, size.height / 2),
    //   100,
    //   paint,
    // );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CardClipper extends CustomClipper<Path> {
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    // path.quadraticBezierTo(
    //   size.width / 2, // control point x
    //   size.height + 20, // control point y
    //   0, // destination x
    //   size.height, // destination y
    // );
    path.arcToPoint(
      Offset(0, size.height),
      radius: const Radius.circular(20),
    );

    return path;
  }

  bool shouldReclip(_CardClipper oldClipper) => true;
}

class _BlueCard extends StatelessWidget {
  const _BlueCard({
    Key? key,
    required this.size,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue,
        ),
        child: Center(
          child: Text(
            'Blue',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
