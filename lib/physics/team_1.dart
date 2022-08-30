import 'dart:async';
import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:collection/collection.dart';

class Phoenix extends StatefulWidget {
  const Phoenix({Key? key, required this.child}) : super(key: key);

  final Widget child;

  static void reset(BuildContext context) {
    final _InheritedPhoenix? result =
        context.dependOnInheritedWidgetOfExactType<_InheritedPhoenix>();
    assert(result != null, 'No Phoenix found in context');
    return result!.reset();
  }

  @override
  State<Phoenix> createState() => _PhoenixState();
}

class _PhoenixState extends State<Phoenix> {
  var key = UniqueKey();

  void reset() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedPhoenix(
      key: key,
      reset: reset,
      child: widget.child,
    );
  }
}

class _InheritedPhoenix extends InheritedWidget {
  const _InheritedPhoenix({
    Key? key,
    required Widget child,
    required this.reset,
  }) : super(key: key, child: child);
  final VoidCallback reset;

  @override
  bool updateShouldNotify(_InheritedPhoenix old) {
    return false;
  }
}

class PhysicsTeam1 extends TeamWidget {
  const PhysicsTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Team1');

  @override
  Widget build(BuildContext context) {
    return Phoenix(
      child: Material(
        color: Colors.black,
        child: _Physics(),
      ),
    );
  }
}

class _Physics extends StatelessWidget {
  const _Physics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: WindFieldPlayground(
              child: ForceFieldVisualizer(),
            ),
          ),
          ElevatedButton(
            onPressed: () => Phoenix.reset(context),
            child: Text('Reset'),
          ),
        ],
      ),
    );
  }
}

class GravityFieldPlayground extends StatefulWidget {
  const GravityFieldPlayground({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<GravityFieldPlayground> createState() => _GravityFieldPlaygroundState();
}

class _GravityFieldPlaygroundState extends State<GravityFieldPlayground> {
  final minMass = 1e3;
  final maxMass = 1e15;

  final pointPosition = math.Vector2(200, 400);
  late var gravityPoints = IList([
    math.Vector2(pointPosition.x, pointPosition.y - 100),
    math.Vector2(pointPosition.x, pointPosition.y + 100),
  ]);
  late var gravityBallMasses = List.generate(
    gravityPoints.length,
    (index) => 1e9,
  ).toIList();

  @override
  Widget build(BuildContext context) {
    final gravityBallColors = gravityBallMasses.map((gravityBallMass) {
      final massRatio = (gravityBallMass - minMass) / (maxMass - minMass);
      final minHue = 190; // Blue
      final maxHue = 360; // Red
      return HSLColor.fromAHSL(
        1,
        (maxHue - minHue) * massRatio + minHue,
        0.9,
        0.5,
      ).toColor();
    }).toIList();
    final gravityBallSizes =
        IList(gravityBallMasses.map((gravityBallMass) => math.Vector2(25, 25)));
    final gravityFields = IList([
      for (var i = 0; i < gravityPoints.length; i++)
        GravityField(
          origin: gravityPoints[i],
          mass: gravityBallMasses[i],
        ),
    ]);

    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              () {
                Widget child = widget.child;

                for (final field in gravityFields) {
                  child = ForceField(
                    field: field,
                    child: child,
                  );
                }

                return child;
              }(),
              for (var i = 0; i < gravityPoints.length; i++)
                () {
                  final gravityPoint = gravityPoints[i];
                  final gravityBallSize = gravityBallSizes[i];
                  final gravityBallColor = gravityBallColors[i];

                  return Positioned(
                    left: gravityPoint.x - gravityBallSize.x / 2,
                    top: gravityPoint.y - gravityBallSize.y / 2,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          gravityPoint.x += details.delta.dx;
                          gravityPoint.y += details.delta.dy;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: gravityBallColor,
                          shape: BoxShape.circle,
                        ),
                        width: gravityBallSize.x,
                        height: gravityBallSize.y,
                      ),
                    ),
                  );
                }(),
            ],
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < gravityPoints.length; i++)
              () {
                final gravityBallMass = gravityBallMasses[i];
                final gravityBallColor = gravityBallColors[i];
                return Slider(
                  activeColor: gravityBallColor,
                  inactiveColor: gravityBallColor.withOpacity(0.5),
                  value: gravityBallMass,
                  min: minMass,
                  max: maxMass,
                  onChanged: (value) {
                    setState(() {
                      gravityBallMasses = gravityBallMasses.replace(i, value);
                    });
                  },
                );
              }(),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  gravityPoints = gravityPoints.add(
                    math.Vector2(
                      Random().nextDouble() * 200,
                      Random().nextDouble() * 200,
                    ),
                  );
                  gravityBallMasses = gravityBallMasses.add(1000.0);
                });
              },
              child: Text('Add Gravity Point'),
            ),
          ],
        ),
      ],
    );
  }
}

class WindFieldPlayground extends StatefulWidget {
  const WindFieldPlayground({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<WindFieldPlayground> createState() => _WindFieldPlaygroundState();
}

class _WindFieldPlaygroundState extends State<WindFieldPlayground> {
  final minWindSpeed = 1e-3;
  final maxWindSpeed = 1e-2;

  var windsCount = 1;
  late var windDirections = List.generate(
    windsCount,
    (_) => math.Vector2(0, -maxWindSpeed),
  ).toIList();
  late var windArrowColors =
      List.generate(windsCount, (_) => randomColor()).toIList();

  int randomSign() => Random().nextInt(2) * 2 - 1;

  math.Vector2 randomWindDirection() {
    final randomSpeed =
        randomSign() * (Random().nextDouble() * (maxWindSpeed - minWindSpeed)) +
            minWindSpeed;

    final normalizedRandomVector = math.Vector2.random().normalized();

    return normalizedRandomVector * randomSpeed;
  }

  Color randomColor() => HSLColor.fromAHSL(
        1,
        Random().nextDouble() * 360,
        0.7,
        0.5,
      ).toColor();

  // Draw a disc painted in [color] with a little white point positioned relative
  // to the direction of the wind.
  Widget windDirectionController({
    required math.Vector2 direction,
    required Color color,
    required void Function(math.Vector2 newDirection) onChanged,
  }) {
    final discDimension = 50.0;
    final dotDimension = 10.0;

    final localDirection = () {
      double ratioSpeed(double speed) {
        return (speed - minWindSpeed) / (maxWindSpeed - minWindSpeed);
      }

      return math.Vector2(
        ratioSpeed(direction.x) * discDimension / 2,
        ratioSpeed(direction.y) * discDimension / 2,
      );
    }();

    math.Vector2 localPositionToDirection(Offset localPosition) {
      final localPositionRatio = math.Vector2(
        (localPosition.dx / (discDimension / 2) - 1).clamp(-1, 1),
        (localPosition.dy / (discDimension / 2) - 1).clamp(-1, 1),
      );
      final direction = math.Vector2(
        localPositionRatio.x * (maxWindSpeed - minWindSpeed) + minWindSpeed,
        localPositionRatio.y * (maxWindSpeed - minWindSpeed) + minWindSpeed,
      );
      return direction;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanUpdate: (details) {
          onChanged(localPositionToDirection(details.localPosition));
        },
        onTapDown: (details) {
          onChanged(localPositionToDirection(details.localPosition));
        },
        child: Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          width: discDimension,
          height: discDimension,
          child: Transform.rotate(
            angle: atan2(direction.y, direction.x),
            child: Transform.translate(
              offset: Offset(localDirection.length, 0),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  width: dotDimension,
                  height: dotDimension,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final windFields = IList([
      for (var i = 0; i < windsCount; i++)
        WindField(velocity: windDirections[i]),
    ]);

    return Column(
      children: [
        Expanded(
          child: () {
            Widget child = widget.child;

            for (final field in windFields) {
              child = ForceField(
                field: field,
                child: child,
              );
            }

            return child;
          }(),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < windsCount; i++)
              () {
                final windArrowDirection = windDirections[i];
                final windArrowColor = windArrowColors[i];
                return windDirectionController(
                  direction: windArrowDirection,
                  color: windArrowColor,
                  onChanged: (newDirection) {
                    setState(() {
                      windDirections = windDirections.replace(
                        i,
                        newDirection,
                      );
                    });
                  },
                );
              }(),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  windDirections = windDirections.add(randomWindDirection());
                  windArrowColors = windArrowColors.add(randomColor());
                });
              },
              child: Text('Add Wind Point'),
            ),
          ],
        ),
      ],
    );
  }
}

/// Places [child] in the given [field]
class ForceField extends StatelessWidget {
  const ForceField({
    Key? key,
    required this.field,
    required this.child,
  }) : super(key: key);

  final ForceFieldBase field;
  final Widget child;

  static ForceFieldBase resultOf(BuildContext context) {
    final _InheritedForceField? result =
        context.dependOnInheritedWidgetOfExactType<_InheritedForceField>();
    assert(result != null, 'No ForceField found in context');
    return result!.field;
  }

  static ForceFieldBase? _maybeResultOf(BuildContext context) {
    final _InheritedForceField? result =
        context.dependOnInheritedWidgetOfExactType<_InheritedForceField>();
    return result?.field;
  }

  @override
  Widget build(BuildContext context) {
    final parentField = _maybeResultOf(context);
    return _InheritedForceField(
      field: ResultingField(
        fields: IList([
          if (parentField != null) parentField,
          field,
        ]),
      ),
      child: child,
    );
  }
}

class _InheritedForceField extends InheritedWidget {
  const _InheritedForceField({
    Key? key,
    required Widget child,
    required this.field,
  }) : super(key: key, child: child);

  final ForceFieldBase field;

  @override
  bool updateShouldNotify(_InheritedForceField old) {
    return field != old.field;
  }
}

class ForceFieldVisualizer extends StatelessWidget {
  const ForceFieldVisualizer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final field = ForceField.resultOf(context);

    final xCount = 10;
    final yCount = 10;

    return LayoutBuilder(
      builder: (context, layout) {
        final size = Size(layout.maxWidth, layout.maxHeight);

        final cellSize = math.Vector2(
          size.width / xCount,
          size.height / yCount,
        );

        final particles = [
          for (var x = 0; x < xCount; x++)
            for (var y = 0; y < yCount; y++)
              Particle(
                movement: MovementProperties(
                  position: math.Vector2(
                    x * cellSize.x + cellSize.x / 2,
                    y * cellSize.y + cellSize.y / 2,
                  ),
                  velocity: math.Vector2.zero(),
                  acceleration: math.Vector2.zero(),
                ),
                properties: PhysicProperties(mass: 10),
              ),
        ];

        final forces =
            particles.map((particle) => field.computeFor(particle)).toList();

        final maxForce = forces.map((f) => f.length).reduce(max);
        final normalizedForces = forces
            .map(
              (force) => force / maxForce,
            )
            .toList();

        final iconSize = 24.0;

        return Stack(
          children: [
            ParticleWidget(),
            for (final particle in particles)
              () {
                final index = particles.indexOf(particle);

                final position = particle.movement.position;

                final normalizedForce = normalizedForces[index];
                // angle to the right
                final angle = atan2(normalizedForce.y, normalizedForce.x);

                return Positioned(
                  left: position.x - iconSize / 2,
                  top: position.y - iconSize / 2,
                  child: Transform.rotate(
                    angle: angle,
                    child: Transform.scale(
                      scaleX: 1 + normalizedForce.length,
                      child: Icon(
                        Icons.arrow_forward,
                        size: iconSize,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }(),
          ],
        );
      },
    );
  }
}

class ParticleWidget extends StatefulWidget {
  const ParticleWidget({Key? key}) : super(key: key);

  @override
  State<ParticleWidget> createState() => _ParticleWidgetState();
}

class _ParticleWidgetState extends State<ParticleWidget>
    with SingleTickerProviderStateMixin {
  var particle = Particle(
    movement: MovementProperties(
      position: math.Vector2(200, 150),
      velocity: math.Vector2(0, 0),
      acceleration: math.Vector2.zero(),
    ),
    properties: PhysicProperties(mass: 100),
  );

  late final Ticker ticker;

  initState() {
    super.initState();
    ticker = createTicker((elapsed) {
      final elapsedSeconds = elapsed.inMicroseconds / 1e6;
      final forceField = ForceField.resultOf(context);
      final force = forceField.computeFor(particle);
      final acceleration = force / particle.properties.mass;
      final velocity =
          particle.movement.velocity + acceleration * elapsedSeconds;
      final position = particle.movement.position + velocity * elapsedSeconds;
      setState(() {
        particle = particle.copyWith(
          movement: particle.movement.copyWith(
            velocity: velocity,
            acceleration: acceleration,
            position: position,
          ),
        );
      });
    });
    ticker.start();
  }

  @override
  dispose() {
    ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final particleSize = 24.0;
    return Stack(
      children: [
        Positioned(
          left: particle.movement.position.x - particleSize / 2,
          top: particle.movement.position.y - particleSize / 2,
          child: Container(
            width: particleSize,
            height: particleSize,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}

class PhysicProperties {
  const PhysicProperties({required this.mass});

  final double mass;

  copyWith({double? mass}) => PhysicProperties(mass: mass ?? this.mass);
}

class MovementProperties {
  const MovementProperties({
    required this.position,
    required this.velocity,
    required this.acceleration,
  });

  final math.Vector2 position;
  final math.Vector2 velocity;
  final math.Vector2 acceleration;

  copyWith({
    math.Vector2? position,
    math.Vector2? velocity,
    math.Vector2? acceleration,
  }) {
    return MovementProperties(
      position: position ?? this.position,
      velocity: velocity ?? this.velocity,
      acceleration: acceleration ?? this.acceleration,
    );
  }
}

class Particle {
  Particle({
    required this.movement,
    required this.properties,
  });

  final MovementProperties movement;
  final PhysicProperties properties;

  copyWith({
    MovementProperties? movement,
    PhysicProperties? properties,
  }) {
    return Particle(
      movement: movement ?? this.movement,
      properties: properties ?? this.properties,
    );
  }
}

abstract class ForceFieldBase {
  math.Vector2 computeFor(Particle particle);
}

class GravityField implements ForceFieldBase {
  const GravityField({
    required this.origin,
    required this.mass,
  });

  final double gravity = 6.67e-11;
  final math.Vector2 origin;
  final double mass;

  math.Vector2 computeFor(Particle particle) {
    final d = particle.movement.position.distanceTo(origin);
    final d2 = d * d;
    final force = -gravity * particle.properties.mass * mass / d2;

    final unit = (particle.movement.position - origin).normalized();

    return unit.scaled(force);
  }
}

class ResultingField implements ForceFieldBase {
  ResultingField({
    required this.fields,
  });

  final IList<ForceFieldBase> fields;

  math.Vector2 computeFor(Particle particle) {
    return fields
        .map((field) => field.computeFor(particle))
        .reduce((a, b) => a + b);
  }
}

class WindField implements ForceFieldBase {
  WindField({
    required this.velocity,
  });

  final math.Vector2 velocity;
  final airDensity = 1.225;

  math.Vector2 computeFor(Particle particle) {
    final particleArea = 1.0;

    double forceOnAxis(velocityOnAxis) =>
        particleArea * pow(velocityOnAxis, 2) / pow(airDensity, 2);
    final force = math.Vector2(velocity.x.sign * forceOnAxis(velocity.x),
        velocity.y.sign * forceOnAxis(velocity.y));

    return force;
  }
}
