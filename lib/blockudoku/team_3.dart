import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class BlockudokuTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<BlockudokuTeam3> createState() => _BlockudokuTeam3State();
}

class _BlockudokuTeam3State extends State<BlockudokuTeam3> {
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
