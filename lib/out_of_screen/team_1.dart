import 'package:bam_dojo/helpers/team_class.dart';
import 'package:bam_dojo/out_of_screen/out_of_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class OutOfScreenTeam1 extends TeamWidget {
  const OutOfScreenTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Team1');

  @override
  Widget build(BuildContext context) {
    return AvatarLinkProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Material(
          child: SafeArea(
            // Try DojoOutOfScreen.outOfScreenCard to get the card design
            child: GesturePhysics(),
          ),
        ),
      ),
    );
  }
}

class GesturePhysics extends StatefulWidget {
  const GesturePhysics({super.key});

  @override
  State<GesturePhysics> createState() => _GesturePhysicsState();
}

class _GesturePhysicsState extends State<GesturePhysics>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _controller.addListener(() {
      setState(() {
        _dragAlignment = _animation.value;
      });
    });
  }

  late Animation<Alignment> _animation;

  Alignment _dragAlignment = Alignment.center;

  void _runAnimation(Size size) {
    final pixelsPerSecond = Offset(0, 100);

    // used by the animation controller.
    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 1,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    _animation = _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment.center,
      ),
    );
    _controller.animateWith(simulation);

    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      // onTap: _runAnimation,
      onPanDown: (details) {},
      onPanUpdate: (details) {
        setState(() {
          _dragAlignment += Alignment(
            details.delta.dx / (size.width / 2),
            details.delta.dy / (size.height / 2),
          );
        });
      },
      onPanEnd: (details) {
        _runAnimation(size);
      },
      child: Align(
          alignment: _dragAlignment, child: DojoOutOfScreen.outOfScreenCard()),
    );
  }
}
