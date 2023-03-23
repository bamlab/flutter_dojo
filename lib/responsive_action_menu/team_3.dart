import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'responsive_action_menu.dart';

class ResponsiveActionMenuTeam3 extends TeamWidget {
  const ResponsiveActionMenuTeam3({
    Key? key,
  }) : super(key: key, teamName: 'Team3');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromRGBO(238, 188, 175, 80),
                    Color.fromRGBO(216, 91, 175, 80),
                    Color.fromRGBO(130, 174, 230, 80),
                  ],
                ),
              ),
            ),
          ),
          Center(child: _MyMenu()),
        ],
      ),
    );
  }
}

class _MyMenu extends StatefulWidget {
  const _MyMenu({Key? key}) : super(key: key);

  @override
  State<_MyMenu> createState() => _MyMenuState();
}

class _MyMenuState extends State<_MyMenu> {
  double? yOffset = null;
  final key = GlobalKey();

  final padding = 20.0;
  final itemHeight = 60.0;
  final separatorHeight = 20.0;
  late final overRectangleHeight = itemHeight + 20;

  void setClamppedYOffset(double? value) {
    setState(() {
      yOffset = value?.clamp(
        padding,
        (key.currentContext?.size?.height ?? 0) - overRectangleHeight,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: LayoutBuilder(builder: (context, constraints) {
        final initialWidth = constraints.maxWidth * 0.7;
        final overRectangleWidth = initialWidth + 40;

        final yOffset = this.yOffset;

        return SizedBox(
          width: initialWidth,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              if (yOffset != null)
                Positioned(
                  left: (initialWidth - overRectangleWidth) / 2,
                  width: overRectangleWidth,
                  top: (itemHeight - overRectangleHeight) / 2 + yOffset,
                  height: overRectangleHeight,
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: Duration(milliseconds: 200),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: child!,
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ColoredBox(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              GestureDetector(
                onPanStart: (details) {
                  setClamppedYOffset(details.localPosition.dy - itemHeight / 2);
                },
                onPanUpdate: (details) {
                  setClamppedYOffset(this.yOffset! + details.delta.dy);
                },
                onPanEnd: (details) {
                  setClamppedYOffset(null);
                },
                child: SizedBox(
                  width: initialWidth,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ColoredBox(
                      color: Colors.white.withOpacity(0.7),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: _UserTiles(
                          padding: padding,
                          itemHeight: itemHeight,
                          separatorHeight: separatorHeight,
                          yOffset: yOffset ?? 0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _UserTiles extends StatelessWidget {
  const _UserTiles({
    required this.padding,
    required this.itemHeight,
    required this.separatorHeight,
    required this.yOffset,
  });

  final double padding;
  final double itemHeight;
  final double separatorHeight;
  final double yOffset;

  double gaussian({
    required double x,
    required double sigma,
    required double mu,
  }) {
    return 1 /
        (sigma * sqrt(2 * pi)) *
        exp(-pow((x - mu), 2) / (2 * pow(sigma, 2)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: buildSeparated(
        DojoResponsiveActionMenu.users.mapIndexed((index, user) {
          final itemPosition =
              padding + itemHeight * index + separatorHeight * index;

          final child = UserListTileBody(
            user: user,
            height: itemHeight,
          );

          final sigmaScale = 10.0;

          final scale = 1 +
              2 *
                  gaussian(
                    x: itemPosition,
                    sigma: sigmaScale,
                    mu: yOffset,
                  );

          final sigmaDeplacement = 5.0;

          final yDeplacement = (gaussian(
                    x: itemPosition,
                    sigma: sigmaDeplacement,
                    mu: yOffset - 10,
                  ) -
                  gaussian(
                    x: itemPosition,
                    sigma: sigmaDeplacement,
                    mu: yOffset + 10,
                  )) *
              10;

          return Transform.scale(
            scale: scale,
            child: Transform.translate(
              child: child,
              offset: Offset(0, yDeplacement),
            ),
          );
        }),
        separator: SizedBox(height: separatorHeight),
      ),
    );
  }
}
