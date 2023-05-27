import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

import 'animated_button.dart';

class AnimatedButtonTeam2 extends TeamWidget {
  const AnimatedButtonTeam2({
    Key? key,
  }) : super(key: key, teamName: 'Team2');

  @override
  Widget build(BuildContext context) {
    return AnimatedButtonStyleProvider(
      child: Material(
        child: Center(
          child: _Button(),
        ),
      ),
    );
  }
}

class _Button extends StatefulWidget {
  const _Button({Key? key}) : super(key: key);

  @override
  State<_Button> createState() => _ButtonState();
}

class _ButtonState extends State<_Button> with TickerProviderStateMixin {
  late final iconController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 300),
  );
  late final textController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 300),
  );

  @override
  void initState() {
    super.initState();
    iconController.addListener(() => setState(() {}));
    textController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    iconController.dispose();
    textController.dispose();
    super.dispose();
  }

  _onHoverChanged(bool isHovered) {
    if (isHovered) {
      iconController.animateTo(1, curve: Curves.easeOutExpo);
      textController.animateTo(1, curve: Curves.easeOut);
    } else {
      iconController.reverse();
      textController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final iconSize = 24.0;
    final padding = 16.0;

    return ClipRect(
      child: ElevatedButton(
        onHover: _onHoverChanged,
        style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.all(padding))),
        onPressed: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.translate(
              offset: Offset(-(iconSize + padding) * iconController.value, 0),
              child: SizedBox.square(
                dimension: iconSize,
                child: DojoAnimatedButton.appleIcon,
              ),
            ),
            const SizedBox(width: 8),
            Transform.translate(
              offset: Offset(-(iconSize + padding) * textController.value, 0),
              child: Text('Download for mac'),
            ),
            SizedOverflowBox(
              alignment: Alignment.centerLeft,
              size: Size.zero,
              child: Transform.translate(
                offset: Offset(-(iconSize + padding) * iconController.value, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: padding),
                    SizedBox.square(
                      dimension: iconSize,
                      child: Icon(Icons.arrow_forward_rounded),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
