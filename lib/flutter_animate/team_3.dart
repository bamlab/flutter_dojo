import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class FlutterAnimateTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<FlutterAnimateTeam3> createState() => _FlutterAnimateTeam3State();
}

class _FlutterAnimateTeam3State extends State<FlutterAnimateTeam3> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 120, left: 10, right: 10),
            child: Column(children: [
              TitleTile(),
              SizedBox(height: 50),
              SomeTile(),
              SizedBox(height: 20),
              SomeTile(),
              SizedBox(height: 20),
              SomeTile(),
              SizedBox(height: 20),
              SomeTile(),
              SomeTile(),
            ]),
          ),
        ),
      ),
    );
  }
}

class TitleTile extends StatelessWidget {
  const TitleTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text('Shimmer me', style: TextStyle(fontSize: 40)),
        subtitle: Text('Please animate me!'),
        leading: Icon(Icons.ac_unit),
        trailing: Icon(Icons.ac_unit),
        tileColor: Colors.lightBlue,
      ),
    );
  }
}

class SomeTile extends StatelessWidget {
  const SomeTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListTile(
        title: Text('Useless(?) tile'),
        subtitle: Text('Please animate me!'),
      ),
    );
  }
}
