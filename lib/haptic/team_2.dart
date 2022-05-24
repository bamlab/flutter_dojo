import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:video_player/video_player.dart';

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
    return const Scaffold(
      backgroundColor: Colors.black,
      body: DraggableCard(),
    );
  }
}

/// A draggable card that moves back to [Alignment.center] when it's
/// released.
class DraggableCard extends StatefulWidget {
  const DraggableCard({Key? key}) : super(key: key);

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

  late VideoPlayerController _videoController;
  late VideoPlayerController _videoController2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _controller.addListener(() {
      setState(() {
        _dragAlignment = _animation.value;
      });
    });

    _videoController = VideoPlayerController.asset(
      'assets/videos/Untitled.mov',
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      })
      ..play()
      ..setLooping(true);

    _videoController2 = VideoPlayerController.asset(
      'assets/videos/Untitled2.mov',
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      })
      ..play()
      ..setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _videoController.dispose();
    _videoController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = isFreelyDragged ? 100.0 : size.width;
    final height = isFreelyDragged ? 100.0 : size.height / 2;
    final underHeight = isFreelyDragged ? size.height : size.height / 2;

    final Size controllerSize = _videoController.value.size;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0) + const EdgeInsets.only(top: 32),
          child: AnimatedContainer(
            width: size.width,
            height: underHeight - 62,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            clipBehavior: Clip.hardEdge,
            duration: const Duration(milliseconds: 50),
            child: FittedBox(
              alignment: Alignment.center,
              clipBehavior: Clip.hardEdge,
              fit: BoxFit.fitHeight,
              child: SizedBox(
                width: controllerSize.width,
                height: controllerSize.height,
                child: VideoPlayer(_videoController2),
              ),
            ),
          ),
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedContainer(
                width: width,
                height: height,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(16)),
                clipBehavior: Clip.hardEdge,
                duration: const Duration(milliseconds: 50),
                child: FittedBox(
                  alignment: Alignment.center,
                  clipBehavior: Clip.hardEdge,
                  fit: BoxFit.fitHeight,
                  child: SizedBox(
                    width: controllerSize.width,
                    height: controllerSize.height,
                    child: VideoPlayer(_videoController),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
