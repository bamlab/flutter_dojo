import 'package:bam_dojo/calendar_drag/team_1.dart';
import 'package:bam_dojo/calendar_drag/team_2.dart';
import 'package:bam_dojo/calendar_drag/team_3.dart';
import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

final _teams = <TeamWidget>[
  const CalendarTeam1(),
  const CalendarTeam2(),
  const CalendarTeam3()
];

class Event {
  final DateTime startDate;
  final DateTime endDate;
  final String name;
  final Color color;

  Event(this.startDate, this.endDate, this.name, this.color);
}

class CalendarData {
  final green = const Color(0xFF71F146);
  final pink = const Color(0xFFEA55C1);
  final blue = const Color(0xFF5569EA);

  late final events = <Event>[
    Event(
      DateTime(2022, 1, 1, 10, 0, 0),
      DateTime(2022, 1, 1, 11, 0, 0),
      'Piscine',
      green,
    ),
    Event(
      DateTime(2022, 1, 1, 13, 0, 0),
      DateTime(2022, 1, 1, 14, 30, 0),
      'Karaoké',
      pink,
    ),
    Event(
      DateTime(2022, 1, 1, 16, 0, 0),
      DateTime(2022, 1, 1, 17, 0, 0),
      'Concert',
      blue,
    ),
  ];
}

class DojoCalendarDrag extends DojoWidget {
  DojoCalendarDrag({
    Key? key,
  }) : super(key: key, dojoName: 'Calendar Drag', teams: _teams);
}