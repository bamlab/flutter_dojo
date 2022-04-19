import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

import 'calendar.dart';

class CalendarTeam1 extends TeamWidget {
  const CalendarTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Louis Lucas');

  @override
  Widget build(BuildContext context) {
    final eventHeight = 80.0;
    return Scaffold(
      body: Center(
        // Show this events in a column
        child: ListView.separated(
          separatorBuilder: (context, index) => Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey.withOpacity(0.5),
          ),
          itemCount: 23,
          itemBuilder: (context, index) {
            Widget child;
            final eventIndex = CalendarData().events.indexWhere(
                  (event) => event.startDate.hour == index,
                );
            if (eventIndex == -1) {
              child = SizedBox.shrink();
            } else {
              child = EventWidget(
                event: CalendarData().events[eventIndex],
              );
            }

            final _now = DateTime.now();
            if (index == _now.hour) {
              child = Stack(
                children: [
                  child,
                  Positioned(
                    top: _now.minute / 60 * eventHeight,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 2,
                      width: double.infinity,
                      color: Colors.red,
                    ),
                  ),
                ],
              );
            }
            return SizedBox(
              height: eventHeight,
              child: child,
            );
          },
        ),
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
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                event.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                event.startDate.hour.toString() +
                    ' - ' +
                    event.endDate.hour.toString(),
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
