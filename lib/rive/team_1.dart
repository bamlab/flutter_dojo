import 'package:bam_dojo/helpers/team_class.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<RiveTeam1> createState() => _RiveTeam1State();
}

class _RiveTeam1State extends State<RiveTeam1> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: Center(child: LocationPinAnimation(dimension: 200))),
    );
  }
}

class LocationPinAnimation extends StatefulWidget {
  const LocationPinAnimation({super.key, required this.dimension});

  final double dimension;

  @override
  State<LocationPinAnimation> createState() => _LocationPinAnimationState();
}

class _LocationPinAnimationState extends State<LocationPinAnimation> {
  StateMachineController? _controller;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: widget.dimension,
      child: RiveAnimation.asset(

        fit: BoxFit.cover,
        'assets/images/user_location_pin.riv',
        onInit: (artboard) {
          _controller = StateMachineController.fromArtboard(
            artboard,
            'Animation Main',
          );
          final controller = _controller;
          if (controller == null) {
            return;
          }
          // The controller is not a StateMachineController
          // in tests
          // coverage:ignore-start
          artboard.addController(controller);
          final states = getAnimationMainStateMachineInputs();

          for (final input in controller.inputs) {
            // Support only boolean inputs for now
            if (states.containsKey(input.name) &&
                input.type == SMIType.boolean) {
              input.value = states[input.name];
            }
          }
        },
      ),
    );
  }
}

enum AnimationMainStateMachineInputs {
  primary(name: 'Primary'),
  white(name: 'WHITE'),
  yuge(name: 'YUGE'),
  scv(name: 'SCV'),
  gmd(name: 'GMD'),
  tvi(name: 'STVI');

  const AnimationMainStateMachineInputs({required this.name});

  final String name;
}

IMap<String, bool> getAnimationMainStateMachineInputs() {
  var states = IMap(const <String, bool>{});

  states.add(
    AnimationMainStateMachineInputs.white.name,
    true,
  );

  // Add all other states to false.
  for (final state in AnimationMainStateMachineInputs.values) {
    if (!states.containsKey(state.name)) {
      states = states.add(state.name, false);
    }
  }

  return states;
}
