import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class RoundScrollbarTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<RoundScrollbarTeam1> createState() => _RoundScrollbarTeam1State();
}

class _RoundScrollbarTeam1State extends State<RoundScrollbarTeam1> {
  final letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
  late final randomColors = letters
      .mapIndexed(
        (index, _) => Color_.fromHSV(
          hue: index * 360 / (letters.length),
          saturation: 0.6,
        ),
      )
      .toList();

  final controller = PageController(
    viewportFraction: 0.45,
    initialPage: 22,
  );

  double roundOffsetRatio = 0;

  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.addListener(() {
        setState(() {
          // roundOffsetRatio = controller.offset / (controller.position.maxScrollExtent + controller.position.viewportDimension  - 300);
          // print('controller.position.maxScrollExtent: ${controller.position.maxScrollExtent}');
          // print('controller.position.viewportDimension: ${controller.position.viewportDimension}');
          // roundOffsetRatio = controller.offset / (controller.position.maxScrollExtent + controller.position.viewportDimension*(1-controller.viewportFraction));
          roundOffsetRatio = controller.offset / (controller.position.maxScrollExtent + controller.position.viewportDimension);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  top: MediaQuery.of(context).viewPadding.top,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: PageView.builder(

                      controller: controller,
                      scrollDirection: Axis.vertical,
                      clipBehavior: Clip.none,
                      padEnds: false,
                      itemCount: letters.length,
                      itemBuilder: (context, index) {
                        final letter = letters[index];
                        return _LetterColumn(
                          letter: letter,
                          color: randomColors[index],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: _ScrollbarLettersColumn(
              letters: letters,
              roundOffsetRatio: roundOffsetRatio,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScrollbarLettersColumn extends StatelessWidget {
  const _ScrollbarLettersColumn({
    Key? key,
    required this.letters,
    required this.roundOffsetRatio,
  }) : super(key: key);

  final List<String> letters;

  final double roundOffsetRatio;
  final sigma = 30;

  double gaussian(double x) {
    return exp(-x * x / (2 * sigma * sigma));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final letterHeight = constraints.maxHeight / letters.length;
      final roundWidgetSize = letterHeight;
      final roundOffset =
          roundOffsetRatio * (constraints.maxHeight - roundWidgetSize + letterHeight) +
              roundWidgetSize / 2;
      return ColoredBox(
        color: Colors.redAccent,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: EdgeInsets.only(right: roundWidgetSize + 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: letters.mapIndexed(
                  (index, letter) {
                    final xOffset = gaussian(letterHeight * index +
                            letterHeight / 2 -
                            roundOffset) *
                        roundWidgetSize;
                    return Expanded(
                      child: Transform.translate(
                        offset: Offset(-xOffset, 0),
                        child: ColoredBox(
                          color: Colors.white,
                          child: _ScrollbarLetterRow(letter: letter),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
            Positioned(
              top: roundOffset - roundWidgetSize / 2,
              right: 10,
              child: _RoundWidget(size: roundWidgetSize),
            ),
          ],
        ),
      );
    });
  }
}

class _RoundWidget extends StatelessWidget {
  const _RoundWidget({Key? key, required this.size}) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
    );
  }
}

class _ScrollbarLetterRow extends StatelessWidget {
  const _ScrollbarLetterRow({Key? key, required this.letter}) : super(key: key);

  final String letter;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(letter),
        SizedBox(width: 5),
        Container(height: 1, width: 10, color: Colors.black),
        SizedBox(width: 5),
      ],
    );
  }
}

class _LetterColumn extends StatelessWidget {
  const _LetterColumn({
    Key? key,
    required this.letter,
    required this.color,
  }) : super(key: key);

  final String letter;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // letter
          SizedBox.square(
            dimension: 50,
            child: Center(
              child: Text(
                letter,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ...List.filled(
            4,
            _FakeColoredListView(color: color),
          )
        ],
      ),
    );
  }
}

class _FakeColoredListView extends StatelessWidget {
  const _FakeColoredListView({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox.square(
        dimension: 50,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5, right: 20),
        child: Container(
          height: 20,
          width: 200,
          color: color,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5, right: 40),
        child: Container(
          height: 20,
          width: 100,
          color: color.withOpacity(0.5),
        ),
      ),
    );
  }
}

extension Color_ on Color {
  static Color fromHSV({
    required double hue,
    double saturation = 1,
    double value = 1,
    double a = 1.0,
  }) {
    final double r, g, b;
    final int i;
    final double f, p, q, t;

    // Make sure our arguments stay in-range
    hue = hue.clamp(0, 360) / 60;
    saturation = saturation.clamp(0, 1);
    value = value.clamp(0, 1);

    i = hue.floor();
    f = hue - i;
    p = value * (1 - saturation);
    q = value * (1 - saturation * f);
    t = value * (1 - saturation * (1 - f));

    switch (i) {
      case 0:
        r = value;
        g = t;
        b = p;
        break;
      case 1:
        r = q;
        g = value;
        b = p;
        break;
      case 2:
        r = p;
        g = value;
        b = t;
        break;
      case 3:
        r = p;
        g = q;
        b = value;
        break;
      case 4:
        r = t;
        g = p;
        b = value;
        break;
      default: // case 5:
        r = value;
        g = p;
        b = q;
    }

    return Color.fromARGB(
      (a * 255).round(),
      (r * 255).round(),
      (g * 255).round(),
      (b * 255).round(),
    );
  }
}
