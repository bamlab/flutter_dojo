import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class ProgressBarTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<ProgressBarTeam1> createState() => _ProgressBarTeam1State();
}

class _ProgressBarTeam1State extends State<ProgressBarTeam1> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200.0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 180.0,
              child: Divider(
                color: Colors.grey,
                thickness: 2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                  4,
                  (index) => Icon(
                        Icons.circle,
                        color: index == 0 ? Colors.red : Colors.grey,
                        size: index == 0 ? 24.0 : 16.0,
                      )),
            )
          ],
        ),
      ),
    );
  }
}
