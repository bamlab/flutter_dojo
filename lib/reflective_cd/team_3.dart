import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:bam_dojo/reflective_cd/reflective_cd.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ReflectiveCDTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<ReflectiveCDTeam3> createState() => _ReflectiveCDTeam3State();
}

class _ReflectiveCDTeam3State extends State<ReflectiveCDTeam3> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: availableCameras(),
      builder: (context, cameras) {
        if (cameras.hasData)
          return ReflectiveCDBase(
            reflectiveCD: _ReflectiveCD(cameras.data![1]),
          );
        return SizedBox.shrink();
      },
    );
  }
}

class _ReflectiveCD extends StatefulWidget {
  const _ReflectiveCD(this.camera);

  final CameraDescription camera;

  @override
  State<_ReflectiveCD> createState() => _ReflectiveCDState();
}

class _ReflectiveCDState extends State<_ReflectiveCD> {
  late final controller = CameraController(widget.camera, ResolutionPreset.max);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.initialize(),
      builder: (context, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: LayoutBuilder(builder: (context, constraints) {
            return Stack(
              children: [
                Image.asset('assets/images/cd_case.jpg'),
                Positioned.fill(
                  child: Transform.translate(
                    offset: const Offset(16, 2),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: ClipOval(
                          clipper: CircleClipper(),
                          child: Stack(
                            children: [
                              const _RotatingCD(),
                              IgnorePointer(
                                child: Opacity(
                                  opacity: 0.2,
                                  child: OverflowBox(
                                    maxWidth: constraints.maxWidth,
                                    maxHeight: constraints.maxHeight,
                                    child: CameraPreview(controller),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }
}

class CircleClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}

class _RotatingCD extends StatefulWidget {
  const _RotatingCD();

  @override
  State<_RotatingCD> createState() => _RotatingCDState();
}

class _RotatingCDState extends State<_RotatingCD> {
  double rotation = 0;
  GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: GestureDetector(
        onPanUpdate: (details) {
          final size = key.currentContext!.size;
          final x = details.localPosition.dy - size!.width / 2;
          final y = details.localPosition.dx - size.height / 2;
          final delta = atan(x / y);
          setState(() {
            rotation = delta;
          });
        },
        child: Transform.rotate(
          angle: rotation,
          child: Image.asset('assets/images/cd.png'),
        ),
      ),
    );
  }
}
