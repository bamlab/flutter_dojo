import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FlutterAnimateTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<FlutterAnimateTeam1> createState() => _FlutterAnimateTeam1State();
}

class _FlutterAnimateTeam1State extends State<FlutterAnimateTeam1> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 120, left: 10, right: 10),
            child: Column(children: [
              TitleTile()
                  .animate()
                  .move(begin: Offset(-200, 0), duration: 600.ms)
                  .animate(
                    delay: 600.ms,
                    onPlay: (controller) => controller.repeat(),
                  )
                  .shimmer(angle: 40, color: Colors.white, duration: 1.seconds),
              SizedBox(height: 50),
              ...[
                SomeTile(),
                SizedBox(height: 20),
                SomeTile(),
                SizedBox(height: 20),
                SomeTile(),
                SizedBox(height: 20),
                SomeTile(),
                SizedBox(height: 20),
                SomeTile(),
              ]
                  .animate(interval: 50.ms)
                  .move(begin: Offset(-600, 0), duration: 600.ms)
                  .then()
                  .fade()
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
          color: Colors.lightBlue[900] ?? Colors.white,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text('Shimmer me',
            style: TextStyle(fontSize: 40, color: Colors.lightBlue[900])),
        subtitle: Text('Please animate me!',
            style: TextStyle(color: Colors.lightBlue[900])),
        leading: Icon(Icons.ac_unit, color: Colors.lightBlue[900]),
        trailing: Icon(Icons.ac_unit, color: Colors.lightBlue[900]),
        tileColor: Colors.lightBlue[200],
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
