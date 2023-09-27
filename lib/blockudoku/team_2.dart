import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

const _size = Size(50, 50);
const _idleColor = Colors.grey;
const _hoverColor = Colors.blueGrey;

class BlockudokuTeam2 extends StatefulWidget with TeamMixin {
  final teamName = 'Team2';

  @override
  State<BlockudokuTeam2> createState() => _BlockudokuTeam2State();
}

class _BlockudokuTeam2State extends State<BlockudokuTeam2> {
  var color = Colors.grey;
  var color2 = Colors.grey;
  var color3 = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _CustomDraggable(Colors.red),
              SizedBox(height: 50),
              _CustomDraggable(Colors.blue),
              SizedBox(height: 50),
              _CustomDragTarget(
                size: _size,
                idleColor: _idleColor,
                hoverColor: _hoverColor,
              ),
              SizedBox(height: 50),
              _CustomDragTarget(
                size: _size,
                idleColor: _idleColor,
                hoverColor: _hoverColor,
              ),
              SizedBox(height: 50),
              _CustomDragTarget(
                size: _size,
                idleColor: _idleColor,
                hoverColor: _hoverColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomDragTarget extends StatefulWidget {
  const _CustomDragTarget({
    required this.size,
    required this.idleColor,
    required this.hoverColor,
  });

  final Size size;
  final Color idleColor;
  final Color hoverColor;

  @override
  State<_CustomDragTarget> createState() => __CustomDragTargetState();
}

class __CustomDragTargetState extends State<_CustomDragTarget> {
  late Color currentColor = widget.idleColor;

  @override
  Widget build(BuildContext context) {
    return DragTarget<Color>(
      onWillAccept: (data) => data != currentColor,
      onAccept: (data) => setState(() => currentColor = data),
      builder: (context, candidateData, rejectedData) {
        return Container(
          height: widget.size.height,
          width: widget.size.width,
          color: candidateData.isNotEmpty ? widget.hoverColor : currentColor,
        );
      },
    );
  }
}

class _CustomDraggable extends StatefulWidget {
  const _CustomDraggable(this.color);

  final Color color;

  @override
  State<_CustomDraggable> createState() => __CustomDraggableState();
}

class __CustomDraggableState extends State<_CustomDraggable> {
  @override
  Widget build(BuildContext context) {
    return Draggable<Color>(
      data: widget.color,
      child: Container(height: 50, width: 50, color: widget.color),
      feedback: Container(height: 50, width: 50, color: widget.color),
      childWhenDragging: SizedBox(height: 50, width: 50),
    );
  }
}
