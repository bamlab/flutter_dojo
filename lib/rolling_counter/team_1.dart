import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class RollingCounterTeam1 extends TeamWidget {
  const RollingCounterTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Team1');

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: _RollingCounter(),
            ),
          )
        ],
      ),
    );
  }
}

class _RollingCounter extends StatefulWidget {
  const _RollingCounter({Key? key}) : super(key: key);

  @override
  State<_RollingCounter> createState() => _RollingCounterState();
}

class _RollingCounterState extends State<_RollingCounter> {
  final _numberOfDigits = 10;
  var _numberOfVisibleDigits = 3;
  late final _controllers = [
    for (int i = 0; i < _numberOfDigits; i++) PageController()
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 100,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < _numberOfDigits; i++)
                () {
                  final controller = _controllers[i];
                  final isVisible = i < _numberOfVisibleDigits;
                  return AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: isVisible ? 1 : 0,
                      child: SizedBox(
                        width: isVisible ? 50 : 0,
                        child: _RollingNumber(
                          key: ValueKey(controller),
                          controller: controller,
                        ),
                      ),
                    ),
                  );
                }(),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _numberOfVisibleDigits = Random().nextInt(5) + 3;
              for (final controller in _controllers) {
                controller.animateToPage(
                  Random().nextInt(10),
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              }
            });
          },
          child: Text('Change value'),
        ),
      ],
    );
  }
}

class _RollingNumber extends StatelessWidget {
  const _RollingNumber({
    Key? key,
    required PageController controller,
  })  : _controller = controller,
        super(key: key);

  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      scrollDirection: Axis.vertical,
      children: List.generate(10, (index) => _NumberCounter(index: index)),
    );
  }
}

class _NumberCounter extends StatelessWidget {
  const _NumberCounter({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        index.toString(),
      ),
    );
  }
}
