import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

import 'calendar_drag.dart';

class CalendarTeam2 extends TeamWidget {
  const CalendarTeam2({
    Key? key,
  }) : super(key: key, teamName: 'Vincent Lucas');

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CalendarTeam(),
    );
  }
}

class CalendarTeam extends StatefulWidget {
  const CalendarTeam({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  State<CalendarTeam> createState() => _CalendarTeamState();
}

class _CalendarTeamState extends State<CalendarTeam> {
  @override
  Widget build(BuildContext context) {
    const eventHeight = 80.0;
    return Scaffold(
      body: Center(
        // Show this events in a column
        child: _CreateEventHandler(
          height: eventHeight,
          child: Container(
            color: Colors.blue,
            height: eventHeight,
          ),
        ),
      ),
    );
  }
}

class _CreateEventHandler extends StatefulWidget {
  const _CreateEventHandler({
    Key? key,
    required this.child,
    required this.height,
  }) : super(key: key);

  final Widget child;
  final double height;

  @override
  State<_CreateEventHandler> createState() => _CreateEventHandlerState();
}

class _CreateEventHandlerState extends State<_CreateEventHandler> {
  var _isDragging = false;
  var _initialPosTop = 0.0;
  var _initialPosBottom = 0.0;
  double? maybeTopPos;
  double? maybeBottomPos;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (details) {
        setState(() {
          _isDragging = true;
        });
        _initialPosTop = details.localPosition.dy;
        _initialPosBottom = details.localPosition.dy;
      },
      onVerticalDragUpdate: (details) {
        setState(() {
          if (details.localPosition.dy > _initialPosBottom) {
            maybeTopPos = null;
            maybeBottomPos = details.localPosition.dy;
          } else if (details.localPosition.dy < _initialPosTop) {
            maybeTopPos = details.localPosition.dy;
            maybeBottomPos = null;
          } else {
            maybeTopPos = null;
            maybeBottomPos = null;
          }
        });
      },
      onVerticalDragEnd: (details) {
        setState(() {
          _isDragging = false;
          _initialPosTop = 0.0;
          _initialPosBottom = 0.0;
          maybeTopPos = null;
          maybeBottomPos = null;
        });
      },
      child: Stack(
        children: [
          widget.child,
          if (_isDragging)
            Positioned(
              top: maybeTopPos ?? _initialPosTop,
              height: (maybeBottomPos ?? _initialPosBottom) -
                  (maybeTopPos ?? _initialPosTop),
              left: 0,
              right: 0,
              child: Container(
                color: Colors.red,
              ),
            ),
        ],
      ),
    );
  }
}

class EventWidget extends StatelessWidget {
  const EventWidget({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: event.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 5,
            decoration: BoxDecoration(
              color: event.color,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                event.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                event.startDate.hour.toString() +
                    ' - ' +
                    event.endDate.hour.toString(),
                style: const TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
