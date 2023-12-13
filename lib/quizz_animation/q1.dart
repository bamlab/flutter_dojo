import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class Question1 extends StatefulWidget with TeamMixin {
  final teamName = 'Question 1';

  @override
  State<Question1> createState() => _Question1State();
}

class _Question1State extends State<Question1> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            width: 200,
            height: 100.0,
            color: Colors.blue,
            child: const FlutterLogo(size: 75),
          ),
        ),
      ),
    );
  }
}
