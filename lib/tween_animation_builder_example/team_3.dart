import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class TweenAnimationBuilderExampleTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<TweenAnimationBuilderExampleTeam3> createState() =>
      _TweenAnimationBuilderExampleTeam3State();
}

class _TweenAnimationBuilderExampleTeam3State
    extends State<TweenAnimationBuilderExampleTeam3> {
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
