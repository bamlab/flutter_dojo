import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class TweenAnimationBuilderExampleTeam2 extends StatefulWidget with TeamMixin {
  final teamName = 'Team2';

  @override
  State<TweenAnimationBuilderExampleTeam2> createState() =>
      _TweenAnimationBuilderExampleTeam2State();
}

class _TweenAnimationBuilderExampleTeam2State
    extends State<TweenAnimationBuilderExampleTeam2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: () {}, child: Text("Play")),
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 30,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(child: Container(color: Colors.green)),
                      Expanded(child: Container(color: Colors.grey)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
