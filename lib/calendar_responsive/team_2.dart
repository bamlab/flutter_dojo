import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class CalendarTeam2 extends TeamWidget {
  const CalendarTeam2({
    Key? key,
  }) : super(key: key, teamName: 'ContentSquare 2022');

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: _ResponsiveCalendar(),
      ),
    );
  }
}

class _ResponsiveCalendar extends StatefulWidget {
  const _ResponsiveCalendar({Key? key}) : super(key: key);

  @override
  State<_ResponsiveCalendar> createState() => _ResponsiveCalendarState();
}

class _ResponsiveCalendarState extends State<_ResponsiveCalendar> {
  final minWidth = 200;
  var isFirst = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      isFirst = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final numberOfDays = constraints.maxWidth ~/ minWidth;
        final dayWidth = constraints.maxWidth / numberOfDays;

        return Row(
          children: [
            for (var i = 0; i < numberOfDays; i++)
              _CalendarDay(
                key: ValueKey(i),
                width: dayWidth,
                animatedFromZero: !isFirst,
              ),
          ],
        );
      },
    );
  }
}

class _CalendarDay extends StatefulWidget {
  const _CalendarDay({
    Key? key,
    required this.width,
    required this.animatedFromZero,
  }) : super(key: key);

  final double width;

  final bool animatedFromZero;

  @override
  State<_CalendarDay> createState() => _CalendarDayState();
}

class _CalendarDayState extends State<_CalendarDay> {
  final _color = Color.fromARGB(
    255,
    Random().nextInt(255),
    Random().nextInt(255),
    Random().nextInt(255),
  );

  late final double _beginWidth = widget.animatedFromZero ? 0 : widget.width;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 100),
      tween: Tween(
        begin: _beginWidth,
        end: widget.width,
      ),
      builder: (context, width, child) {
        return Container(
          width: width,
          height: double.infinity,
          color: _color,
        );
      },
    );
  }
}
