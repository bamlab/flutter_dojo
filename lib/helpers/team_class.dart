import 'package:flutter/material.dart';

mixin TeamMixin on Widget {
  String get teamName;
}

abstract class TeamWidget extends StatelessWidget with TeamMixin {
  final String teamName;

  const TeamWidget({Key? key, required this.teamName}) : super(key: key);
}

abstract class DojoWidget extends StatelessWidget {
  final String dojoName;
  final List<TeamMixin> teams;

  const DojoWidget({
    Key? key,
    required this.dojoName,
    required this.teams,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dojoName),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: teams
              .map(
                (e) => ListTile(
                  title: Text(e.teamName),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => e),
                    );
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
