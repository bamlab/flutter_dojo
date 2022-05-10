// ignore_for_file: avoid_print

import 'dart:math';

import 'package:bam_dojo/calendar/calendar.dart';
import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class CalendarTeam1 extends TeamWidget {
  const CalendarTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Guillaume & Guillaume');

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: _DragDetector()));
  }
}

class _Event {
  final double height;
  final double origin;

  _Event(this.height, this.origin);
}

class _DragDetector extends StatefulWidget {
  const _DragDetector({Key? key}) : super(key: key);

  @override
  State<_DragDetector> createState() => __DragDetectorState();
}

final data = CalendarData();

class __DragDetectorState extends State<_DragDetector> {
  bool isMoving = false;
  double _height = 0;
  double _origin = 0;

  final events = <_Event>[];
  final colors = [data.blue, data.pink, data.green];

  @override
  Widget build(BuildContext context) {
    print(isMoving);
    return GestureDetector(
      onLongPress: () {
        setState(() {
          isMoving = true;
        });
      },
      onLongPressStart: (update) {
        print(update.localPosition);
        setState(() {
          _origin = update.localPosition.dy;
        });
      },
      onLongPressMoveUpdate: (update) {
        print("update ${update.localOffsetFromOrigin}");
        setState(() {
          _height = update.localOffsetFromOrigin.dy;
        });
      },
      onLongPressEnd: (_) {
        events.add(_Event(_height, _origin));
        setState(() {
          isMoving = false;
          _height = 0;
          _origin = 0;
        });
      },
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey[100],
          ),
          ...events.map(
            (e) {
              final color = colors[events.indexOf(e) % 3];
              return Positioned(
                top: e.height > 0 ? e.origin : e.origin + e.height,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 16,
                    height: max(2, e.height.abs()),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      border: Border.all(color: color),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              );
            },
          ).toList(),
          if (isMoving)
            _EventPositionned(
              height: _height,
              origin: _origin,
              color: Colors.grey,
            ),
        ],
      ),
    );
  }
}

class _EventPositionned extends StatelessWidget {
  const _EventPositionned({
    Key? key,
    required double height,
    required double origin,
    required Color color,
    bool finished = false,
  })  : _height = height,
        _origin = origin,
        _color = color,
        _finished = finished,
        super(key: key);

  final double _height;
  final double _origin;
  final Color _color;
  final bool _finished;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _height > 0 ? _origin : _origin + _height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width - 16,
          height: max(2, _height.abs()),
          decoration: BoxDecoration(
            color: _finished ? _color.withOpacity(0.2) : null,
            border: Border.all(color: _color),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
