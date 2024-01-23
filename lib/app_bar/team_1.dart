import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class AppBarTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<AppBarTeam1> createState() => _AppBarTeam1State();
}

class _AppBarTeam1State extends State<AppBarTeam1> {
  var index = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: switch (index) {
          0 => Colors.red,
          1 => Colors.green,
          2 => Colors.blue,
          _ => Colors.cyan,
        },
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
            // BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Logout'),
          ],
          currentIndex: index,
          onTap: (value) => setState(() => index = value),
        ),
      ),
    );
  }
}
