import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class AnimatedNavigationBarTeam2 extends StatefulWidget with TeamMixin {
  final teamName = 'Team2';

  @override
  State<AnimatedNavigationBarTeam2> createState() =>
      _AnimatedNavigationBarTeam2State();
}

class _AnimatedNavigationBarTeam2State
    extends State<AnimatedNavigationBarTeam2> {
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
          ],
          currentIndex: index,
          onTap: (value) => setState(() => index = value),
        ),
      ),
    );
  }
}
