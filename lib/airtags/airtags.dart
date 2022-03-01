import 'package:bam_dojo/airtags/team_1.dart';
import 'package:bam_dojo/airtags/team_2.dart';
import 'package:bam_dojo/airtags/team_3.dart';
import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

final _teams = <TeamWidget>[
  const AirTagsTeam1(),
  const AirTagsTeam2(),
  const AirTagsTeam3()
];

class AirTagsData {
  final carIcon = Icons.directions_car;
  final walkIcon = Icons.directions_walk;
  final batteryIcon = Icons.battery_charging_full;
  final playIcon = Icons.play_arrow;
  final navifationIcon = Icons.navigation;

  final scooterUrl =
      "https://firebasestorage.googleapis.com/v0/b/orga-47ea2.appspot.com/o/assets%2FPikPng.com_scooty-png_384580.png?alt=media&token=71b0a1d7-9e6c-44f5-9d67-af10cccc6841";

  final airpodMaxUrl =
      "https://firebasestorage.googleapis.com/v0/b/orga-47ea2.appspot.com/o/assets%2FUntitled.png?alt=media&token=3daab8c8-02d9-4948-925f-2b086d8d59ce";
}

class DojoAirTags extends DojoWidget {
  const DojoAirTags({
    Key? key,
  }) : super(key: key, dojoName: 'AirTags');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dojoName),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _teams
              .map((e) => ListTile(
                    title: Text(e.teamName),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => e,
                        ),
                      );
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }
}
