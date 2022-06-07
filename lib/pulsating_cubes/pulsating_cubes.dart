import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

/// Design: https://dribbble.com/shots/10792593-Pulsating-cubes

final _teams = <TeamWidget>[
  const PulsatingCubesTeam1(),
  const PulsatingCubesTeam2(),
  const PulsatingCubesTeam3(),
];

class DojoPulsatingCubes extends DojoWidget {
  DojoPulsatingCubes({
    Key? key,
  }) : super(key: key, dojoName: 'Pulsating Cubes', teams: _teams);
}

/// A cube which can be rotated in 3D space.
class Cube extends StatelessWidget {
  const Cube({
    Key? key,
    required this.size,
    required this.color,
  }) : super(key: key);

  final double size;

  final Color color;

  @override
  Widget build(BuildContext context) {
    // Use 6 _Face widgets to build the cube.
    return Stack(
      children: [
        Transform(
          transform: Matrix4.identity()
            ..rotateY(pi / 2)
            ..translate(-size / 2, 0.0, size),
          child: _Face(
            color: Colors.green,
            size: size,
          ),
        ),
        Transform(
          transform: Matrix4.identity()
            ..rotateX(3 * pi / 2)
            ..translate(0.0, -size / 2, 0.0),
          child: _Face(
            color: Colors.red,
            size: size,
          ),
        ),
        Transform(
          transform: Matrix4.identity()
            ..rotateX(pi / 2)
            ..translate(0.0, -size / 2, -size),
          child: _Face(
            color: Colors.purple,
            size: size,
          ),
        ),
        Transform(
          transform: Matrix4.identity()..translate(0.0, 0.0, -size / 2),
          child: _Face(
            color: Colors.blue,
            size: size,
          ),
        ),
        Transform(
          transform: Matrix4.identity()
            ..rotateY(pi)
            ..translate(-size, 0.0, -size / 2),
          child: _Face(
            color: Colors.yellow,
            size: size,
          ),
        ),
        Transform(
          transform: Matrix4.identity()
            ..rotateY(3 * pi / 2)
            ..translate(-size / 2, 0.0, 0.0),
          child: _Face(
            color: Colors.orange,
            size: size,
          ),
        ),
      ],
    );
  }
}

/// Face of a cube.
class _Face extends StatelessWidget {
  const _Face({
    Key? key,
    required this.color,
    required this.size,
  }) : super(key: key);

  final Color color;

  final double size;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: SizedBox(
        width: size,
        height: size,
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var xRotation = 0.0;
  var yRotation = 0.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: RawGestureDetector(
          behavior: HitTestBehavior.translucent,
          gestures: <Type, GestureRecognizerFactory>{
            PanGestureRecognizer:
                GestureRecognizerFactoryWithHandlers<PanGestureRecognizer>(
              () => PanGestureRecognizer(),
              (PanGestureRecognizer instance) {
                instance.onUpdate = ((details) {
                  setState(() {
                    yRotation -= details.delta.dx / 100;
                    xRotation += details.delta.dy / 100;
                  });
                });
              },
            ),
          },
          child: Center(
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateX(xRotation)
                ..rotateY(yRotation),
              child: const Cube(
                size: 100,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
