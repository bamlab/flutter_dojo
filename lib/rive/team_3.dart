import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<RiveTeam3> createState() => _RiveTeam3State();
}

class _RiveTeam3State extends State<RiveTeam3> {
  late StateMachineController _controller;

  void _onInit(Artboard art) {
    var ctrl = StateMachineController.fromArtboard(art, 'State Machine 1');
    if (ctrl == null) {
      return;
    }

    ctrl.isActive = true;
    art.addController(ctrl);
    final _bump = ctrl.findInput<bool>('YUGE');
    _bump?.value = true;
    setState(() {
      _controller = ctrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 100,
                height: 100,
                child:
                    RiveAnimation.asset('assets/rive/user_location_pin.riv')),
            SizedBox(
                width: 100,
                height: 100,
                child: RiveAnimation.asset(
                  'assets/rive/loader_cda.riv',
                  onInit: _onInit,
                )),
          ],
        ),
      ),
    ));
  }
}
