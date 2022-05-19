import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class HapticTeam2 extends TeamWidget {
  const HapticTeam2({
    Key? key,
  }) : super(key: key, teamName: 'Guillaume & Lucas');

  @override
  Widget build(BuildContext context) {
    return const PhysicsCardDragDemo();
  }
}

class PhysicsCardDragDemo extends StatelessWidget {
  const PhysicsCardDragDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const DraggableCard(
        child: FlutterLogo(
          size: 128,
        ),
      ),
    );
  }
}

/// A draggable card that moves back to [Alignment.center] when it's
/// released.
class DraggableCard extends StatefulWidget {
  const DraggableCard({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  _DraggableCardState createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  /// The alignment of the card as it is dragged or being animated.
  ///
  /// While the card is being dragged, this value is set to the values computed
  /// in the GestureDetector onPanUpdate callback. If the animation is running,
  /// this value is set to the value of the [_animation].
  Alignment _dragAlignment = Alignment.bottomCenter;

  late Animation<Alignment> _animation;

  bool get isFreelyDragged => _dragAlignment.y < 0;
  Offset? panPosition;

  /// Calculates and runs a [SpringSimulation].
  void _runAnimation(Offset pixelsPerSecond, Size size) {
    print(_dragAlignment.y);
    _animation = _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: isFreelyDragged ? Alignment.topCenter : Alignment.bottomCenter,
      ),
    );

    // Calculate the velocity relative to the unit interval, [0,1],
    // used by the animation controller.
    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 50,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    _controller.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _controller.addListener(() {
      setState(() {
        _dragAlignment = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = isFreelyDragged ? 50.0 : size.width;
    final height = isFreelyDragged ? 50.0 : size.height / 2;
    print(isFreelyDragged);
    print(panPosition);
    return Stack(
      children: [
        Container(
          color: Colors.amber,
          width: double.infinity,
          height: 200,
        ),
        GestureDetector(
          onPanDown: (details) {
            _controller.stop();
          },
          onPanUpdate: (details) {
            panPosition = details.globalPosition;
            setState(() {
              _dragAlignment += Alignment(
                details.delta.dx / (size.width / 2),
                details.delta.dy / (size.height / 2),
              );
            });
          },
          onPanEnd: (details) {
            _runAnimation(details.velocity.pixelsPerSecond, size);
          },
          child: Align(
            alignment: isFreelyDragged
                ? Alignment(
                    (panPosition!.dx / size.width) * 2 - 1,
                    (panPosition!.dy / size.height) * 2 - 1 - 0.2,
                  )
                : _dragAlignment,
            child: AnimatedContainer(
              width: width,
              height: height,
              duration: const Duration(milliseconds: 50),
              child: Card(
                child: widget.child,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
