import 'package:bam_dojo/calendar/team_1.dart';
import 'package:bam_dojo/calendar/team_2.dart';
import 'package:bam_dojo/calendar/team_3.dart';
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

  Event(this.startDate, this.endDate, this.name);
}

class CalendarData {
  final green = const Color(0xFFEEF7EB);
  final pink = const Color(0xFFFDEBF8);
  final blue = const Color(0XFFE7F6FC);

  final events = <Event>[
    Event(
      DateTime(2022, 1, 1, 10, 0, 0),
      DateTime(2022, 1, 1, 11, 0, 0),
      'Piscine',
    ),
    Event(
      DateTime(2022, 1, 1, 13, 0, 0),
      DateTime(2022, 1, 1, 14, 30, 0),
      'Karaoké',
    ),
    Event(
      DateTime(2022, 1, 1, 16, 0, 0),
      DateTime(2022, 1, 1, 17, 0, 0),
      'Concert',
    ),
  ];
}

class DojoCalendar extends DojoWidget {
  DojoCalendar({
    Key? key,
  }) : super(key: key, dojoName: 'Calendar', teams: _teams);
}
