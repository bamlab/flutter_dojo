import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class Question4 extends StatefulWidget with TeamMixin {
  final teamName = 'Question 4';

  @override
  State<Question4> createState() => _TweenAnimationBuilderExampleTeam1State();
}

class _TweenAnimationBuilderExampleTeam1State extends State<Question4> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: null, child: Text("Play")),
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
