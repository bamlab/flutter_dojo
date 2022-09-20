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
          child: ClipPath(
            clipper: _CardClipper(),
            child: Transform.translate(
              offset: Offset(0, cardOffset),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: _BlueCard(
                  size: cardSize,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
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
