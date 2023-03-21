import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

import 'out_of_screen.dart';

class OutOfScreenTeam3 extends TeamWidget {
  const OutOfScreenTeam3({
    Key? key,
  }) : super(key: key, teamName: 'Team3');

  @override
  Widget build(BuildContext context) {
    // Use https://docs.flutter.dev/cookbook/animation/physics-simulation
    return AvatarLinkProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Material(
          child: SafeArea(
            child: _BigWidget(),
          ),
        ),
      ),
    );
  }
}

class _BigWidget extends StatefulWidget {
  const _BigWidget({Key? key}) : super(key: key);

  @override
  State<_BigWidget> createState() => _BigWidgetState();
}

class _BigWidgetState extends State<_BigWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double>? _translateAnimation;

  double get translationValue => _translateAnimation?.value ?? 0;

  /// Used to compute the out of screen card height.
  final outOfScreenCardKey = GlobalKey();

  // This will get initialized after the first frame.
  double? outOfScreenCardHeight;

  void _runAnimation() {
    _controller.isCompleted ? _controller.reverse() : _controller.forward();
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
    );

    _controller.addListener(() => setState(() {}));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        final context = outOfScreenCardKey.currentContext!;
        outOfScreenCardHeight = context.size!.height;
        _translateAnimation = _controller.drive(
          Tween(
            begin: 0.0,
            end: outOfScreenCardHeight,
          ),
        );
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

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _runAnimation,
      child: Stack(
        children: [
          Transform.translate(
            offset: Offset(0, -translationValue / 1.5),
            child: Transform(
              alignment: Alignment.center,
              transform: _getCurrentTransformMatrix(),
              child: ColoredBox(
                color: Colors.blueAccent,
                child: DojoOutOfScreen.basicScreen(),
              ),
            ),
          ),
          Positioned(
            top: screenSize.height - translationValue,
            left: 0,
            right: 0,
            child: ColoredBox(
              color: Colors.redAccent,
              child: KeyedSubtree(
                key: outOfScreenCardKey,
                child: DojoOutOfScreen.outOfScreenCard(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
