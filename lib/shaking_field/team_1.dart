import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class ShakingFieldTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<ShakingFieldTeam1> createState() => _ShakingFieldTeam1State();
}

class _ShakingFieldTeam1State extends State<ShakingFieldTeam1> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(decoration: InputDecoration(hintText: 'Shake me')),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {},
                child: Text('Shake'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
