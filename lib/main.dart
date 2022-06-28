import 'package:bam_dojo/airtags/airtags.dart';
import 'package:bam_dojo/airtags_animation/airtags.dart';
import 'package:bam_dojo/bank/bank.dart';
import 'package:bam_dojo/bank_animation/bank_animation.dart';
import 'package:bam_dojo/calendar/calendar.dart';
import 'package:bam_dojo/calendar_drag/calendar_drag.dart';
import 'package:bam_dojo/calendar_responsive/calendar_responsive.dart';
import 'package:bam_dojo/card_hover/card_hover.dart';
import 'package:bam_dojo/haptic/haptic.dart';
import 'package:bam_dojo/helpers/team_class.dart';
import 'package:bam_dojo/pulsating_cubes/pulsating_cubes.dart';
import 'package:bam_dojo/sign_up/sign_up.dart';
import 'package:bam_dojo/surf/surf.dart';
import 'package:bam_dojo/time_machine/time_machine.dart';
import 'package:bam_dojo/twofingers/twofingers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'perspective/perspective.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // To enable Android under navigation bar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: true,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.top],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bam Dojo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DojoPicker(),
    );
  }
}

final _dojos = <DojoWidget>[
  DojoSurf(),
  DojoAirTags(),
  DojoAirTagsAnimation(),
  DojoBank(),
  DojoBankAnimation(),
  DojoCalendar(),
  DojoCalendarDrag(),
  DojoCalendarResponsive(),
  DojoSignUp(),
  DojoCardHover(),
  HapticDojo(),
  TwoFingerDojo(),
  DojoTimeMachine(),
  DojoPulsatingCubes(),
  DojoPerspective(),
];

class DojoPicker extends StatelessWidget {
  const DojoPicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dojo Bam"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _dojos.reversed
              .map(
                (e) =>
                ListTile(
                  title: Text(e.dojoName),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => e,
                      ),
                    );
                  },
                ),
          )
              .toList(),
        ),
      ),
    );
  }
}
