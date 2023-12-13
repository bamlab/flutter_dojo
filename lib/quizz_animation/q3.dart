import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class Question3 extends StatefulWidget with TeamMixin {
  final teamName = 'Question 3';

  @override
  State<Question3> createState() => _Question3State();
}

class _Question3State extends State<Question3> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const HeroExample(),
    );
  }
}

class HeroExample extends StatelessWidget {
  const HeroExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero Sample')),
      body: Container(
        width: 50,
        height: 50,
        color: Colors.red[700]!.withOpacity(0.5),
      ),
    );
  }
}
