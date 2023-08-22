import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class InteractiveToolbarTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<InteractiveToolbarTeam3> createState() =>
      _InteractiveToolbarTeam3State();
}

class _InteractiveToolbarTeam3State extends State<InteractiveToolbarTeam3> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              height: 450,
              width: 70,
              child: Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 20,
                child: OverflowBox(
                  alignment: Alignment.centerLeft,
                  minWidth: 70,
                  maxWidth: 1200,
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return _ToolbarItem();
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ToolbarItem extends StatefulWidget {
  _ToolbarItem();

  final color = randomColor();
  final imageUrl =
      'https://avatars.dicebear.com/api/adventurer/${Random().nextInt(1000)}.png';

  @override
  State<_ToolbarItem> createState() => _ToolbarItemState();
}

class _ToolbarItemState extends State<_ToolbarItem>
    with TickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 100),
  );

  late final _selectedWidthTween = Tween(begin: 70.0, end: 200.0).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 500),
      tween: Tween(begin: 1 / 5, end: 1),
      builder: (context, scaleValue, child) {
        final avatarRadius = 20 * scaleValue;

        return SizedBox(
          height: 70,
          child: AnimatedBuilder(
            animation: _selectedWidthTween,
            builder: (context, child) {
              return OverflowBox(
                alignment: Alignment.centerLeft,
                minWidth: 70,
                maxWidth: _selectedWidthTween.value,
                child: child,
              );
            },
            child: GestureDetector(
              onTapDown: (_) => _animationController.forward(),
              onTapUp: (_) => _animationController.reverse(),
              child: SizedBox.expand(
                child: Padding(
                  padding: EdgeInsets.all(35 - avatarRadius * 5 / 4),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(avatarRadius * 1 / 4),
                      child: CircleAvatar(
                        radius: avatarRadius,
                        backgroundColor: Colors.transparent,
                        child: Image.network(
                          widget.imageUrl,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      child: SizedBox(),
    );
  }
}

Color randomColor() => HSLColor.fromAHSL(
      1,
      Random().nextDouble() * 360,
      0.7,
      0.5,
    ).toColor();
