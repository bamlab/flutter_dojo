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
    with TickerProviderStateMixin {
  final cardSize = 150.0;

  late final cardOffsetTween = Tween<double>(
    begin: 0,
    end: 2 * cardSize,
  ).chain(CurveTween(curve: Curves.easeInBack));

  late final cardRotationTween = Tween<double>(
    begin: 0,
    end: 0.5,
  ).chain(CurveTween(curve: Curves.easeInBack));

  late final cardElevationTween = Tween<double>(
    begin: 2,
    end: 20,
  );

  late final holeSizeTween = Tween<double>(
    begin: 0,
    end: 1.5 * cardSize,
  );

  late final cardOffsetAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  );

  late final holeAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  );

  double get cardOffset =>
      cardOffsetTween.evaluate(cardOffsetAnimationController);

  double get cardRotation =>
      cardRotationTween.evaluate(cardOffsetAnimationController);

  double get cardElevation =>
      cardElevationTween.evaluate(cardOffsetAnimationController);

  double get holeSize => holeSizeTween.evaluate(holeAnimationController);

  @override
  initState() {
    super.initState();
    holeAnimationController.addListener(() => setState(() {}));
    cardOffsetAnimationController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cardOffsetAnimationController.reset();
          holeAnimationController.reset();
        },
        child: const Icon(Icons.lock_reset_outlined),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async {
          holeAnimationController.forward();
          await cardOffsetAnimationController.forward();
          holeAnimationController.reverse();
        },
        child: Center(
          child: ClipPath(
            clipper: _BlackHoleClipper(),
            child: Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                Opacity(
                  opacity: 0,
                  child: SizedBox(
                    width: cardSize * 1.5,
                    child: Image.asset(
                      'assets/images/hole.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  width: holeSize,
                  child: Image.asset(
                    'assets/images/hole.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Transform.translate(
                      offset: Offset(0, cardOffset),
                      child: Transform.rotate(
                        angle: cardRotation,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: _BlueCard(
                            size: cardSize,
                            elevation: cardElevation,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BlackHoleClipper extends CustomClipper<Path> {
  Path getClip(Size size) {
    final path = Path();
    // Start from half the height at the left
    path.moveTo(0, size.height / 2);
    // Go to half the height at the right passing through the bottom center
    // using an arc
    path.arcTo(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width,
        height: size.height,
      ),
      0,
      pi,
      true,
    );
    path.lineTo(0, -1000);

    path.lineTo(size.width, -1000);
    path.close();
    return path;
  }

  bool shouldReclip(_BlackHoleClipper oldClipper) => true;
}

class _BlueCard extends StatelessWidget {
  const _BlueCard({
    Key? key,
    required this.size,
    required this.elevation,
  }) : super(key: key);

  final double size;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      borderRadius: BorderRadius.circular(10),
      child: SizedBox.square(
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
      ),
    );
  }
}
