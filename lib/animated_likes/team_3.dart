import 'dart:async';
import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class AnimatedLikesTeam3 extends TeamWidget {
  const AnimatedLikesTeam3({
    Key? key,
  }) : super(key: key, teamName: 'Team3');

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _FakePost(),
              SizedBox(height: 10),
              _PostReactions(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PostReactions extends StatelessWidget {
  const _PostReactions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ClickableAnimatedButton(
              icon: Icons.favorite,
              color: Colors.redAccent,
            ),
            const SizedBox(width: 16),
            _ClickableAnimatedButton(
              icon: Icons.thumb_up,
              color: Colors.blueAccent,
            ),
            const SizedBox(width: 16),
            _ClickableAnimatedButton(
              icon: Icons.star,
              color: Colors.yellowAccent,
            ),
          ],
        ),
      ),
    );
  }
}

class _ClickableAnimatedButton extends StatefulWidget {
  const _ClickableAnimatedButton({
    Key? key,
    required this.icon,
    required this.color,
  }) : super(key: key);

  final IconData icon;
  final Color color;

  @override
  State<_ClickableAnimatedButton> createState() =>
      _ClickableAnimatedButtonState();
}

class _ClickableAnimatedButtonState extends State<_ClickableAnimatedButton> {
  final _animatedIconsKeys = <Key>[];
  late final icon = Icon(
    widget.icon,
    color: widget.color,
  );
  final iconKey = GlobalKey();

  late final Size size;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final renderBox =
            iconKey.currentContext!.findRenderObject() as RenderBox;
        size = renderBox.size;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ..._animatedIconsKeys.map(
          (key) => _AnimatedIcon(key: key, icon: icon, size: size),
        ),
        GestureDetector(
          onTap: () async {
            setState(() {
              _animatedIconsKeys.add(UniqueKey());
            });
            await Future.delayed(Duration(seconds: 1));
            if (mounted) {
              _animatedIconsKeys.remove(UniqueKey());
            }
          },
          child: KeyedSubtree(
            key: iconKey,
            child: icon,
          ),
        ),
      ],
    );
  }
}

class _AnimatedIcon extends StatefulWidget {
  const _AnimatedIcon({
    Key? key,
    required this.icon,
    required this.size,
  }) : super(key: key);

  final Widget icon;
  final Size size;

  @override
  State<_AnimatedIcon> createState() => _AnimatedIconState();
}

class _AnimatedIconState extends State<_AnimatedIcon> {
  // Random number between -pi/8 and pi/8
  final originAngle = 2 * pi / 8 * Random().nextDouble() - pi / 8;
  var plusOrMinusX = 1;
  var continueTimer = true;

  // The final y position of the icon
  late final endYOffset = -(1.5 + Random().nextDouble()) * widget.size.height;

  final animationDuration = Duration(seconds: 1);

  @override
  void initState() {
    super.initState();
    animateOnX();
  }

  Future<void> animateOnX() async {
    while (continueTimer) {
      final duration = Duration(milliseconds: (100 + Random().nextInt(100)));
      await Future.delayed(duration);
      if (mounted) {
        setState(() => plusOrMinusX *= -1);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    continueTimer = false;
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: originAngle,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: plusOrMinusX * 0.5 * widget.size.width),
        duration: Duration(milliseconds: 100),
        builder: (context, xOffset, child) {
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: endYOffset),
            duration: animationDuration,
            builder: (context, yOffset, child) {
              return TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: animationDuration,
                builder: (context, progress, child) {
                  final fadeStartProgress = 0.5;
                  final fadeDuration =
                      (animationDuration.inMilliseconds * fadeStartProgress)
                          .ceil();

                  return AnimatedOpacity(
                    duration: Duration(milliseconds: fadeDuration),
                    opacity: progress > fadeStartProgress ? 0 : 1,
                    child: child!,
                  );
                },
                child: Transform.translate(
                  offset: Offset(xOffset, yOffset),
                  child: widget.icon,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _FakePost extends StatelessWidget {
  const _FakePost({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // The top part of the card
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                SizedBox(width: 8),
                // The profile picture
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: NetworkImage(
                    'https://avatars.dicebear.com/api/adventurer/${Random().nextInt(1000)}.png',
                  ),
                ),
                SizedBox(width: 8),
                // The name of the person
                Text(
                  'Jane Doe',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 4),
                // The username of the person
                Text(
                  '@janedoe',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          // The comment
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            ),
          ),
          // The bottom part of the card
        ],
      ),
    );
  }
}
