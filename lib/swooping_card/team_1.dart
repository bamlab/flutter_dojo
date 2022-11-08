import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class SwoopingCardTeam1 extends TeamWidget {
  const SwoopingCardTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Team1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _PositionedCard(
            xAlignment: 1,
            enableAnimation: false,
            imageUrl: 'assets/images/card1.png',
          ),
          _PositionedCard(
            xAlignment: 0,
            enableAnimation: true,
            imageUrl: 'assets/images/card2.png',
          ),
          _PositionedCard(
            xAlignment: -1,
            enableAnimation: false,
            imageUrl: 'assets/images/card3.png',
          ),
        ],
      ),
    );
  }
}

class _PositionedCard extends StatefulWidget {
  const _PositionedCard({
    Key? key,
    required this.xAlignment,
    required this.enableAnimation,
    required this.imageUrl,
  }) : super(key: key);

  final double xAlignment;
  final bool enableAnimation;
  final String imageUrl;

  @override
  State<_PositionedCard> createState() => _PositionedCardState();
}

class _PositionedCardState extends State<_PositionedCard>
    with SingleTickerProviderStateMixin {
  late final animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 300),
  );

  double xMapper(double x) {
    final translatedX = (x * 2 - 1);
    return ((-translatedX * translatedX + 1) * 0.2) + widget.xAlignment;
  }

  final yTween =
      Tween(begin: 0.8, end: -0.2).chain(CurveTween(curve: Curves.easeInOut));

  void initState() {
    super.initState();
    animationController.addListener(() => setState(() {}));
  }

  _updatePosition() {
    widget.enableAnimation
        ? animationController.isCompleted
            ? animationController.reverse()
            : animationController.forward()
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: animationController.value + 1,
      child: GestureDetector(
        onTap: _updatePosition,
        child: Align(
          alignment: Alignment(
            xMapper(animationController.value),
            yTween.transform(animationController.value),
          ),
          child: _Card(
            imageUrl: widget.imageUrl,
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 8,
      child: SizedBox(
        width: 100,
        height: 150,
        child: Image.asset(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
