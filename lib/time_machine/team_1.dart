import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class TimeMachineTeam1 extends TeamWidget {
  const TimeMachineTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Team 1');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _FlowMenu(),
        ),
      ),
    );
  }
}

class _FlowMenu extends StatefulWidget {
  _FlowMenu({Key? key}) : super(key: key);

  @override
  State<_FlowMenu> createState() => _FlowMenuState();
}

class _FlowMenuState extends State<_FlowMenu> {
  final color = Color(0xFFFF0000);

  var offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onVerticalDragUpdate: (details){
        setState(() {
          offset += details.delta;
        });
      },
      onVerticalDragEnd: (details){
        setState(() {
          offset = Offset.zero;
        });
      },
      child: Flow(
        delegate: _FlowMenuDelegate(screenSize, offset),
        children: [
          _MyCard(color: color.withOpacity(1)),
          _MyCard(color: color.withOpacity(0.8)),
          _MyCard(color: color.withOpacity(0.6)),
          _MyCard(color: color.withOpacity(0.4)),
          _MyCard(color: color.withOpacity(0.2)),
        ].reversed.toList(),
      ),
    );
  }
}

class _FlowMenuDelegate extends FlowDelegate {
  _FlowMenuDelegate(this.screenSize, this.offset);

  final Size screenSize;
  final Offset offset;

  @override
  void paintChildren(FlowPaintingContext context) {
    final childSize = context.getChildSize(0)!;
    final centerXPosition = screenSize.width / 2 - childSize.width / 2;
    final centerYPosition = (screenSize.height / 2 - childSize.height / 2) ;

    for (int i = 0; i < context.childCount; i++) {
      final localOffset = i == context.childCount - 1  ? offset.dy : 0;

final yPosition = centerYPosition - (context.childCount - i) * 20 + localOffset;
      context.paintChild(i, transform: Matrix4.identity()..translate( centerXPosition, yPosition));
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return true;
  }
}

class _MyCard extends StatelessWidget {
  const _MyCard({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: Card(color: color),
    );
  }
}
