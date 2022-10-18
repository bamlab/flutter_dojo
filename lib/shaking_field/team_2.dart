import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class ShakingFieldTeam2 extends StatefulWidget with TeamMixin {
  final teamName = 'Team2';

  @override
  State<ShakingFieldTeam2> createState() => _ShakingFieldTeam2State();
}

class _ShakingFieldTeam2State extends State<ShakingFieldTeam2> {
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
