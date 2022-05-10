import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class CardHoverTeam1 extends TeamWidget {
  const CardHoverTeam1({Key? key})
      : super(
          teamName: 'The best',
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return const _CardHover();
  }
}

class _CardHover extends StatefulWidget {
  const _CardHover({Key? key}) : super(key: key);

  @override
  State<_CardHover> createState() => _CardHoverState();
}

class _CardHoverState extends State<_CardHover> {
  late Offset _mousePositionFromCenter = Offset.zero;
  late Offset _mousePosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final centerPosition = Offset(
            constraints.maxWidth / 2,
            constraints.maxHeight / 2,
          );
          return MouseRegion(
            onHover: (event) {
              _mousePositionFromCenter = event.position - centerPosition;
              _mousePosition = event.position;
              setState(() {});
            },
            cursor: SystemMouseCursors.none,
            child: Stack(
              children: [
                Center(
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.002)
                      ..rotateX(
                        _mousePositionFromCenter.dy / constraints.maxWidth,
                      )
                      ..rotateY(
                        _mousePositionFromCenter.dx / constraints.maxHeight,
                      ),
                    child: const Card(
                      elevation: 20,
                      color: Colors.blueAccent,
                      child: SizedBox(
                        width: 300,
                        height: 200,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: _mousePosition.dy - 15,
                  left: _mousePosition.dx - 15,
                  height: 30,
                  width: 30,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
