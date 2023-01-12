import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

import 'animated_button.dart';

class AnimatedButtonTeam1 extends TeamWidget {
  const AnimatedButtonTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Team1');

  @override
  Widget build(BuildContext context) {
    return AnimatedButtonStfl();
  }
}

class AnimatedButtonStfl extends StatefulWidget {
  const AnimatedButtonStfl({
    Key? key,
  }) : super(key: key);

  @override
  State<AnimatedButtonStfl> createState() => _AnimatedButtonStflState();
}

class _AnimatedButtonStflState extends State<AnimatedButtonStfl>
    with SingleTickerProviderStateMixin {
  late AnimationController myAnimationController;

  @override
  void initState() {
    super.initState();
    myAnimationController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    // myAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedButtonStyleProvider(
      child: Material(
        child: Center(
          child: ElevatedButton(
            onPressed: () {},
            onHover: (value) {
              if (value)
                myAnimationController.forward();
              else
                myAnimationController.reverse();
            },
            child: AnimatedBuilder(
              animation: myAnimationController,
              builder: (context, child) => Transform.translate(
                offset: Offset(myAnimationController.value * -40, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DojoAnimatedButton.appleIcon,
                    const SizedBox(width: 8),
                    Text('Download for mac'),
                    const SizedBox(width: 8),
                    Icon(Icons.arrow_forward_rounded),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
