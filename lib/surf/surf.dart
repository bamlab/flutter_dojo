import 'package:bam_dojo/helpers/team_class.dart';
import 'package:bam_dojo/surf/team_1.dart';
import 'package:bam_dojo/surf/team_2.dart';
import 'package:bam_dojo/surf/team_3.dart';
import 'package:flutter/material.dart';

final _teams = <TeamWidget>[
  const SurfTeam1(),
  const SurfTeam2(),
  const SurfTeam3()
];

class SurfData {
  final primary = const Color(0XFFb3e5f2);
  final secondary = const Color(0XFF222342);

  final favoriteIcon = Icons.favorite_outline;
  final waveIcon = Icons.waves;

  final surfUrl =
      "https://www.sortiraparis.com/images/80/66131/560283-surf-in-paris-la-nouvelle-experience-aquatique-signee-the-escape-lab.jpg";
  final peopleUrls = [
    "https://randomuser.me/api/portraits/women/75.jpg",
    "https://randomuser.me/api/portraits/women/76.jpg",
    "https://randomuser.me/api/portraits/women/77.jpg",
    "https://randomuser.me/api/portraits/women/78.jpg",
    "https://randomuser.me/api/portraits/women/79.jpg",
    "https://randomuser.me/api/portraits/women/80.jpg",
    "https://randomuser.me/api/portraits/women/81.jpg",
    "https://randomuser.me/api/portraits/women/82.jpg",
    "https://randomuser.me/api/portraits/men/75.jpg",
    "https://randomuser.me/api/portraits/men/76.jpg",
    "https://randomuser.me/api/portraits/men/77.jpg",
    "https://randomuser.me/api/portraits/men/78.jpg",
    "https://randomuser.me/api/portraits/men/79.jpg",
    "https://randomuser.me/api/portraits/men/80.jpg",
    "https://randomuser.me/api/portraits/men/81.jpg",
    "https://randomuser.me/api/portraits/men/82.jpg",
  ];
}

class DojoSurf extends DojoWidget {
  const DojoSurf({
    Key? key,
  }) : super(key: key, dojoName: 'Surf');

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
