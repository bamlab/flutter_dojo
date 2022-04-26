import 'package:bam_dojo/calendar_responsive/base_widget.dart';
import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

const _kBreakpoint = 300;

class CalendarTeam1 extends TeamWidget {
  const CalendarTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Yves Rocher');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        children: List.generate(
          (width / _kBreakpoint).truncate(),
          (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: _AnimatedContainer(
              index: index,
              key: ValueKey("column$index"),
            ),
          ),
        ).toList(),
      ),
    );
  }
}

class _AnimatedContainer extends StatefulWidget {
  const _AnimatedContainer({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  State<_AnimatedContainer> createState() => __AnimatedContainerState();
}

class __AnimatedContainerState extends State<_AnimatedContainer> {
  @override
  Widget build(BuildContext context) {
    final totalWidth = MediaQuery.of(context).size.width;
    final maxIndex = (totalWidth / _kBreakpoint).truncate();
    final containerWidth = (totalWidth - 16 * maxIndex) / maxIndex;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: containerWidth,
      color: Colors.blue,
      child: const BaseCalendarTeam1(),
    );
  }
}
