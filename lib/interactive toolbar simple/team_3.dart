import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class InteractiveToolbarSimpleTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<InteractiveToolbarSimpleTeam3> createState() =>
      _InteractiveToolbarSimpleTeam3State();
}

class _InteractiveToolbarSimpleTeam3State
    extends State<InteractiveToolbarSimpleTeam3> {
  Color firstColor = Colors.red;
  Color secondColor = Colors.blue;

  final firstkey = GlobalKey();
  final secondKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Listener(
            onPointerDown: (event) {
              final position = event.position;
              final firstBox =
                  firstkey.currentContext!.findRenderObject() as RenderBox;
              final secondBox =
                  secondKey.currentContext!.findRenderObject() as RenderBox;

              final firstBoxFrame =
                  firstBox.localToGlobal(Offset.zero) & firstBox.size;
              final secondBoxFrame =
                  secondBox.localToGlobal(Offset.zero) & secondBox.size;

              if (firstBoxFrame.contains(position)) {
                setState(() {
                  firstColor = Colors.green;
                });
              }

              if (secondBoxFrame.contains(position)) {
                setState(() {
                  secondColor = Colors.green;
                });
              }
            },
            onPointerMove: (event) {
              final position = event.position;
              final firstBox =
                  firstkey.currentContext!.findRenderObject() as RenderBox;
              final secondBox =
                  secondKey.currentContext!.findRenderObject() as RenderBox;

              final firstBoxFrame =
                  firstBox.localToGlobal(Offset.zero) & firstBox.size;
              final secondBoxFrame =
                  secondBox.localToGlobal(Offset.zero) & secondBox.size;

              if (firstBoxFrame.contains(position)) {
                setState(() {
                  firstColor = Colors.green;
                });
              } else {
                setState(() {
                  firstColor = Colors.red;
                });
              }

              if (secondBoxFrame.contains(position)) {
                setState(() {
                  secondColor = Colors.green;
                });
              } else {
                setState(() {
                  secondColor = Colors.blue;
                });
              }
            },
            onPointerUp: (event) {
              setState(() {
                firstColor = Colors.red;
                secondColor = Colors.blue;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  key: firstkey,
                  color: firstColor,
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 50),
                Container(
                  key: secondKey,
                  color: secondColor,
                  width: 100,
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
