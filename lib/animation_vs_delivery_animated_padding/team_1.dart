import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class AnimationVsDeliveryAnimatedPaddingTeam1 extends StatefulWidget
    with TeamMixin {
  final teamName = 'Team1';

  @override
  State<AnimationVsDeliveryAnimatedPaddingTeam1> createState() =>
      _AnimationVsDeliveryAnimatedPaddingTeam1State();
}

class _AnimationVsDeliveryAnimatedPaddingTeam1State
    extends State<AnimationVsDeliveryAnimatedPaddingTeam1> {
  static const basePadding = EdgeInsets.symmetric(vertical: 8, horizontal: 16);

  var _endPadding = basePadding;

  @override
  Widget build(BuildContext context) {
    final tween = EdgeInsetsTween(begin: basePadding, end: _endPadding);

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: TweenAnimationBuilder(
            tween: tween,
            curve: Curves.easeOutExpo,
            duration: const Duration(milliseconds: 200),
            builder: (context, value, _) => Listener(
              onPointerDown: (_) => setState(
                () => _endPadding = basePadding * .5,
              ),
              onPointerUp: (_) {
                setState(() => _endPadding = basePadding * 2);
                Future.delayed(
                  const Duration(milliseconds: 200),
                  () => setState(() => _endPadding = basePadding),
                );
              },
              child: FancyButton(padding: value),
            ),
          ),
        ),
      ),
    );
  }
}

class FancyButton extends StatelessWidget {
  const FancyButton({super.key, required this.padding});

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.blue[200],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: padding,
        child: Text("Press me"),
      ),
    );
  }
}
