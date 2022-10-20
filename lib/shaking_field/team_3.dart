import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class ShakingFieldTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<ShakingFieldTeam3> createState() => _ShakingFieldTeam3State();
}

class _ShakingFieldTeam3State extends State<ShakingFieldTeam3>
    with SingleTickerProviderStateMixin {
  final fieldTranslationTween = Tween(begin: -50.0, end: 50.0);
  final animationCurve = Curves.linear;
  late final animationController = AnimationController(
    vsync: this,
  );

  /// Calculates and runs a [SpringSimulation].
  void _runAnimation(double unitsPerSecondX) {
    // Calculate the velocity relative to the unit interval, [0,1],
    // used by the animation controller.
    final unitsPerSecond = Offset(unitsPerSecondX, 0);
    final unitVelocity = unitsPerSecond.distance;
    const spring = SpringDescription(
      mass: 30,
      stiffness: 0.1,
      damping: 1,
    );
    final simulation = SpringSimulation(spring, 0.5, 0.5, -unitVelocity);
    animationController.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();

    animationController.animateTo(0.5, duration: Duration.zero);

    animationController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    animationController.stop();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fieldTranslation = fieldTranslationTween
        .animate(
          CurvedAnimation(parent: animationController, curve: animationCurve),
        )
        .value;

    return Material(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.translate(
                offset: Offset(fieldTranslation, 0),
                child: TextField(
                  decoration: InputDecoration(hintText: 'Shake me'),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  _runAnimation(300.0);
                },
                child: Text('Shake'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
