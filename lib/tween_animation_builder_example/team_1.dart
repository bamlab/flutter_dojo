import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class TweenAnimationBuilderExampleTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<TweenAnimationBuilderExampleTeam1> createState() =>
      _TweenAnimationBuilderExampleTeam1State();
}

class _TweenAnimationBuilderExampleTeam1State
    extends State<TweenAnimationBuilderExampleTeam1> {
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
