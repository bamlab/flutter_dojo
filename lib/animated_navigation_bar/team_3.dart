import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class AnimatedNavigationBarTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<AnimatedNavigationBarTeam3> createState() =>
      _AnimatedNavigationBarTeam3State();
}

class _AnimatedNavigationBarTeam3State
    extends State<AnimatedNavigationBarTeam3> {
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
