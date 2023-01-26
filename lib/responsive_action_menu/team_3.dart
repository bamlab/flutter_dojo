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
    return Material(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              "https://images.unsplash.com/photo-1568826069038-f3de1448e9a1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=922&q=80",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: _MyMenu(),
          ),
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final itemHeight = 60.0;
      final separatorHeight = 20.0;
      final padding = 20.0;

      final initialWidth = constraints.maxWidth * 0.7;
      final overRectangleWidth = initialWidth + 40;
      final overRectangleHeight = itemHeight + 20;

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
                setState(() {
                  this.yOffset = details.localPosition.dy - itemHeight / 2;
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  this.yOffset = this.yOffset! + details.delta.dy;
                });
              },
              onPanEnd: (details) {
                setState(() {
                  this.yOffset = null;
                });
              },
              child: SizedBox(
                width: initialWidth,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ColoredBox(
                    color: Colors.white.withOpacity(0.7),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: buildSeparated(
                          DojoResponsiveActionMenu.users
                              .mapIndexed((index, user) {
                            final itemPosition = padding +
                                itemHeight * index +
                                separatorHeight * index;
                            final yOffset = this.yOffset;

                            final child = UserListTileBody(
                              user: user,
                              height: itemHeight,
                            );

                            if (yOffset == null) {
                              return child;
                            }

                            // Gaussian center at 0 with a standard deviation of 1
                            final sigmaScale = 10.0;

                            final scale = 1 +
                                2 *
                                    gaussian(
                                      x: itemPosition,
                                      sigma: sigmaScale,
                                      mu: yOffset,
                                    );

                            final sigmaDeplacement = 5.0;

                            final yDeplacement =
                                    (gaussian(
                                      x: itemPosition,
                                      sigma: sigmaDeplacement,
                                      mu: yOffset - 10,
                                    ) -

                                    gaussian(
                                      x: itemPosition,
                                      sigma: sigmaDeplacement,
                                      mu: yOffset + 10,
                                    ))*10;

                            print('yDeplacement: $yDeplacement, index: $index');

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
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  double gaussian({
    required double x,
    required double sigma,
    required double mu,
  }) {
    return 1 /
        (sigma * sqrt(2 * pi)) *
        exp(-pow((x - mu), 2) / (2 * pow(sigma, 2)));
  }

  double sigmoid(double x) {
    return 1 / (1 + exp(-x));
  }
}
