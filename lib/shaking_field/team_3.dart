import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class ShakingFieldTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<ShakingFieldTeam3> createState() => _ShakingFieldTeam3State();
}

class _ShakingFieldTeam3State extends State<ShakingFieldTeam3> {
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
