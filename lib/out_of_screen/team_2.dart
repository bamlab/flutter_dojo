import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

import 'out_of_screen.dart';

class OutOfScreenTeam2 extends TeamWidget {
  const OutOfScreenTeam2({
    Key? key,
  }) : super(key: key, teamName: 'Team2');

  @override
  Widget build(BuildContext context) {
    // Use https://docs.flutter.dev/cookbook/animation/physics-simulation
    return AvatarLinkProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Material(
          child: _BigWidget(),
        ),
      ),
    );
  }
}

enum _AnimationState {
  /// The animation is not running.
  idleStart,

  /// The animation is not running.
  idleEnd,

  /// The animation is running forward.
  forward,

  /// The animation is running backward.
  backward,
}

class _BigWidget extends StatefulWidget {
  const _BigWidget({Key? key}) : super(key: key);

  @override
  State<_BigWidget> createState() => _BigWidgetState();
}

class _BigWidgetState extends State<_BigWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  double get translationValue => _controller.value;
  _AnimationState animationState = _AnimationState.idleStart;

  double dragOutOfScreenCardDy = 0;

  /// Used to compute the out of screen card height.
  final outOfScreenCardKey = GlobalKey();

  // This will get initialized after the first frame.
  double? outOfScreenCardHeight;

  void _runAnimation() async {
    final springDescription = SpringDescription(
      mass: 1.5,
      stiffness: 200,
      damping: 11,
    );

    final simulationForward = SpringSimulation(
      springDescription,
      0.0, // starting point
      outOfScreenCardHeight!, // ending point
      2000, // velocity
    );

    final simulationBackward = SpringSimulation(
      springDescription,
      outOfScreenCardHeight!, // ending point
      0.0, // starting point
      2000, // velocity
    );

    switch (animationState) {
      case _AnimationState.idleStart:
        animationState = _AnimationState.forward;
        await _controller.animateWith(simulationForward);
        animationState = _AnimationState.idleEnd;
        break;
      case _AnimationState.idleEnd:
        animationState = _AnimationState.backward;
        await _controller.animateWith(simulationBackward);
        animationState = _AnimationState.idleStart;
        break;
      case _AnimationState.forward:
      case _AnimationState.backward:
        break;
    }
  }

  Matrix4 _getCurrentTransformMatrix() {
    // We can only start translating after the first frame because we need the
    // height of the out of screen card.
    final outOfScreenCardHeight = this.outOfScreenCardHeight;
    final shouldTranslate = outOfScreenCardHeight != null;
    final transformMatrix = Matrix4.identity();
    if (shouldTranslate) {
      transformMatrix
        ..setEntry(
          3,
          2,
          translationValue / outOfScreenCardHeight * -0.00051,
        )
        ..rotateX(translationValue / outOfScreenCardHeight * -0.5);
    }
    return transformMatrix;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      lowerBound: -10000,
      upperBound: 10000,
      value: 0,
    );

    _controller.addListener(() => setState(() {}));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        final context = outOfScreenCardKey.currentContext!;
        outOfScreenCardHeight = context.size!.height;
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
    final screenSize = MediaQuery.of(context).size;

    return ColoredBox(
      color: Colors.grey[200]!,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _runAnimation,
        child: Stack(
          children: [
            Transform.translate(
              offset: Offset(0, -translationValue),
              child: Transform(
                alignment: Alignment.center,
                transform: _getCurrentTransformMatrix(),
                child: PhysicalModel(
                  color: Colors.transparent,
                  shadowColor: Colors.black.withOpacity(1),
                  elevation: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ColoredBox(
                      color: Colors.white,
                      child: SafeArea(
                        child: DojoOutOfScreen.basicScreen(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenSize.height - translationValue * 1.1,
              left: 0,
              right: 0,
              child: Transform.translate(
                offset: Offset(0, dragOutOfScreenCardDy),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onPanUpdate: (details) {
                    setState(() {
                      dragOutOfScreenCardDy += details.delta.dy / 2;
                    });
                    print(dragOutOfScreenCardDy);
                  },
                  child: KeyedSubtree(
                    key: outOfScreenCardKey,
                    child: SafeArea(
                      child: DojoOutOfScreen.outOfScreenCard(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
