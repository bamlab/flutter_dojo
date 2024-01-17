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

const _stepNumber = 4;

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var step = (0, 0, false);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: SizedBox(
              width: 200.0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (!step.$3)
                    Divider(
                      indent: 10,
                      endIndent: 10,
                      color: Colors.grey,
                      thickness: 2,
                    ),
                  Align(
                    alignment:
                        step.$3 ? Alignment.center : Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        //curve: Curves.easeInOut,
                        onEnd: () {
                          setState(() {
                            step = (step.$1, step.$1, step.$3);
                          });
                        },
                        width: step.$3
                            ? 0
                            : (step.$1 * 180 / (_stepNumber - 1)).toDouble(),
                        child: Divider(
                          color: Colors.red,
                          thickness: 2,
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                        _stepNumber,
                        (index) => Positioned(
                              left: step.$3 ? 90 : index * 60,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: AnimatedContainer(
                                  //curve: Curves.easeInCubic,
                                  alignment: Alignment.center,
                                  duration: Duration(milliseconds: 200),
                                  width: index == step.$2 ? 20.0 : 16.0,
                                  height: index == step.$2 ? 20.0 : 16.0,
                                  onEnd: () {
                                    setState(() {
                                      step = (
                                        step.$1,
                                        step.$2,
                                        step.$2 == _stepNumber - 1
                                      );
                                    });
                                  },
                                  color: index <= step.$2
                                      ? Colors.red
                                      : Colors.grey,
                                  child: FittedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: AnimatedSwitcher(
                                        duration: Duration(milliseconds: 200),
                                        child: Icon(
                                          key: ValueKey(index <= step.$2),
                                          index <= step.$2 ? Icons.check : null,
                                          color: index <= step.$2
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
                  step = (
                    step.$1 == _stepNumber - 1 ? 0 : step.$1 + 1,
                    step.$2,
                    step.$3
                  );
                });
              },
              child: Text('Next step')),
        )
      ],
    );
  }
}
