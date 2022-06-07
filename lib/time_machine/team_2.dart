import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class TimeMachineTeam2 extends TeamWidget {
  const TimeMachineTeam2({
    Key? key,
  }) : super(key: key, teamName: 'Team 2');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.black,
      body: const Center(
        child: FlowMenu(),
      ),
    );
  }
}

class FlowMenu extends StatefulWidget {
  const FlowMenu({Key? key}) : super(key: key);

  @override
  State<FlowMenu> createState() => _FlowMenuState();
}

class _FlowMenuState extends State<FlowMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController menuAnimation;
  IconData lastTapped = Icons.notifications;
  final List<Color> menuItems = <Color>[
    Colors.amber,
    Colors.white,
    Colors.pink,
    Colors.red,
    Colors.green
  ];

  double currentScrollOffset = 0;

  void _updateMenu(IconData icon) {
    if (icon != Icons.menu) {
      setState(() => lastTapped = icon);
    }
  }

  @override
  void initState() {
    super.initState();
    menuAnimation = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
  }

  Widget flowMenuItem(Color color) {
    final double buttonDiameter =
        MediaQuery.of(context).size.width / menuItems.length;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          setState(() {
            currentScrollOffset += details.primaryDelta ?? 0;
          });
        },
        child: SizedBox(
          width: 100,
          height: 100,
          child: Card(
            color: color,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: FlowMenuDelegate(
        offset: currentScrollOffset,
        screenWdith: MediaQuery.of(context).size.width,
      ),
      children: menuItems.map<Widget>((color) => flowMenuItem(color)).toList(),
    );
  }
}

class FlowMenuDelegate extends FlowDelegate {
  FlowMenuDelegate({
    required this.offset,
    required this.screenWdith,
  }) : super();

  final double offset;
  final double screenWdith;

  @override
  bool shouldRepaint(FlowMenuDelegate oldDelegate) {
    return offset != oldDelegate.offset;
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    double dx = 0.0;

    double dy = 0.0;
    for (int i = 0; i < context.childCount; ++i) {
      dx = context.getChildSize(i)!.width * i / 2;
      dy = context.getChildSize(i)!.height * i / 2;
      context.paintChild(
        i,
        transform: Matrix4.translationValues(
          screenWdith / 2 - dx,
          dy + offset * 2.5,
          0,
        ).scaled(1 + offset / 100 + i),
        opacity: offset / 50 + i,
      );
    }
  }
}
