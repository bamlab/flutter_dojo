import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class SwoopingCardTeam1 extends TeamWidget {
  const SwoopingCardTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Team1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [_Card()]),
    );
  }
}

class _Card extends StatefulWidget {
  const _Card({Key? key}) : super(key: key);

  @override
  State<_Card> createState() => _CardState();
}

class _CardState extends State<_Card> with SingleTickerProviderStateMixin {
  late final animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 300),
  );

  double xMapper(double x) {
    final translatedX = (x * 2 - 1);
    return (-translatedX * translatedX + 1) * 0.2;
  }

  final yTween =
      Tween(begin: 0.8, end: 0.0).chain(CurveTween(curve: Curves.easeInOut));

  void initState() {
    super.initState();
    animationController.addListener(() => setState(() {}));
  }

  _updatePosition() {
    animationController.forward();
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
          child: Card(
            child: SizedBox.square(
              dimension: 39,
            ),
            color: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}
