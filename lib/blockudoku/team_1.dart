import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class BlockudokuTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<BlockudokuTeam1> createState() => _BlockudokuTeam1State();
}

class _BlockudokuTeam1State extends State<BlockudokuTeam1> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Draggable(
                  child: Container(height: 25, width: 25, color: Colors.red),
                  feedback:
                      Container(height: 25, width: 25, color: Colors.blue)),
              SizedBox(height: 50),
              DragTarget(
                builder: (context, candidateData, rejectedData) {
                  return Container(height: 25, width: 25, color: Colors.grey);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
