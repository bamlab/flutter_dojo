import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class UselessSliderTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<UselessSliderTeam3> createState() => _UselessSliderTeam3State();
}

class _UselessSliderTeam3State extends State<UselessSliderTeam3> {
  var currentScaleOffset = 1.0;
  final originalSquareSize = 100.0;
  late var squareHeight = originalSquareSize;
  late var squareWidth = originalSquareSize;

  final splitAnimationDuration = Duration(milliseconds: 1000);

  var isSplit = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onScaleUpdate: (details) async {
                setState(() {
                  currentScaleOffset = details.scale;
                  if (currentScaleOffset > 2.0) {
                    squareHeight = 50.0;
                    squareWidth = 200.0;
                  }
                });
                await Future.delayed(splitAnimationDuration);
                if (mounted) {
                  setState(() {
                    isSplit = true;
                  });
                }
              },
              child: Center(
                child: Stack(
                  children: [
                    ...isSplit
                        ? [
                            Positioned(
                              top: constraints.maxHeight / 2 -
                                  originalSquareSize / 2,
                              left:
                                  constraints.maxWidth / 2 - originalSquareSize,
                              child: _WhiteBox(
                                height: originalSquareSize,
                                width: originalSquareSize,
                                splitAnimationDuration: splitAnimationDuration,
                              ),
                            ),
                            Positioned(
                              top: constraints.maxHeight / 2 -
                                  originalSquareSize / 2,
                              left: constraints.maxWidth / 2,
                              child: _WhiteBox(
                                height: originalSquareSize,
                                width: originalSquareSize,
                                splitAnimationDuration: splitAnimationDuration,
                              ),
                            ),
                          ]
                        : [
                            _WhiteBox(
                              height: squareHeight,
                              width: squareWidth,
                              splitAnimationDuration: splitAnimationDuration,
                            ),
                          ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _WhiteBox extends StatelessWidget {
  const _WhiteBox({
    Key? key,
    required this.height,
    required this.width,
    required this.splitAnimationDuration,
  }) : super(key: key);

  final double height;
  final double width;
  final Duration splitAnimationDuration;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: splitAnimationDuration,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
