import 'dart:async';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class PerspectiveTeam2 extends TeamWidget {
  const PerspectiveTeam2({
    Key? key,
  }) : super(key: key, teamName: 'Lucas&Vincent');

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromARGB(255, 24, 50, 33),
      child: _Perspective(),
    );
  }
}

class _Perspective extends StatefulWidget {
  const _Perspective({Key? key}) : super(key: key);

  @override
  State<_Perspective> createState() => __PerspectiveState();
}

class __PerspectiveState extends State<_Perspective> {
  var xRotation = 0.0;
  var yRotation = 0.0;

  late final StreamSubscription listener;

  @override
  void initState() {
    super.initState();

    listener = gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        xRotation += event.x / 5;
        yRotation += event.y / 5;
      });

      print(event);
    });
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
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
          child: Text(
            'Change your perspective',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
