import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class ProgressBarTeam2 extends StatefulWidget with TeamMixin {
  final teamName = 'Team2';

  @override
  State<ProgressBarTeam2> createState() => _ProgressBarTeam1State();
}

class _ProgressBarTeam1State extends State<ProgressBarTeam2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}

const _stepNumber = 4;

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var step = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: step == _stepNumber ? 16.0 : 206.0,
              height: 24,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Divider(
                    indent: 10,
                    endIndent: 10,
                    color: Colors.grey,
                    thickness: 2,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width: step == _stepNumber
                            ? 0
                            : (step * 180 / (_stepNumber - 1)).toDouble(),
                        child: Divider(
                          color: Colors.red,
                          thickness: 2,
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: List.generate(
                        _stepNumber,
                        (index) => AnimatedPositioned(
                              duration: Duration(milliseconds: 600),
                              left: step == _stepNumber
                                  ? 0
                                  : index < _stepNumber / 2
                                      ? index * 190 / (_stepNumber - 1)
                                      : null,
                              right: step == _stepNumber
                                  ? 0
                                  : index >= _stepNumber / 2
                                      ? (_stepNumber - index - 1) *
                                          190 /
                                          (_stepNumber - 1)
                                      : null,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: AnimatedContainer(
                                  curve: Curves.easeInCubic,
                                  alignment: Alignment.center,
                                  duration: Duration(milliseconds: 600),
                                  width: index == step ? 24.0 : 16.0,
                                  height: index == step ? 24.0 : 16.0,
                                  color:
                                      index <= step ? Colors.red : Colors.grey,
                                  child: FittedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: AnimatedSwitcher(
                                        duration: Duration(milliseconds: 600),
                                        child: Icon(
                                          key: ValueKey(index <= step),
                                          index <= step ? Icons.check : null,
                                          color: index <= step
                                              ? Colors.white
                                              : Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 70),
          child: ElevatedButton(
              onPressed: () {
                setState(() {
                  step = step == _stepNumber ? 0 : step + 1;
                });
              },
              child: Text('Next step')),
        )
      ],
    );
  }
}