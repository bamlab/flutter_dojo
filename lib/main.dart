import 'package:bam_dojo/helpers/team_class.dart';
import 'package:bam_dojo/surf/surf.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bam Dojo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DojoPicker(),
    );
  }
}

final _dojos = <DojoWidget>[
  const DojoSurf(),
];

class DojoPicker extends StatelessWidget {
  const DojoPicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dojo Bam"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _dojos
              .map((e) => ListTile(
                    title: Text(e.dojoName),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => e,
                        ),
                      );
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }
}
