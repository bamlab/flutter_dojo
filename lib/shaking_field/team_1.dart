import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class ShakingFieldTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<ShakingFieldTeam1> createState() => _ShakingFieldTeam1State();
}

class _ShakingFieldTeam1State extends State<ShakingFieldTeam1>
    with SingleTickerProviderStateMixin {
  final numberOfCycles = 3;

  bool hasError = false;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  late final tween = Tween<double>(begin: 0, end: 1).animate(_animation);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final xOffset = sin(_animation.value * pi * 2 * numberOfCycles) * 20;

    final border = OutlineInputBorder(
      borderSide: BorderSide(
        color: hasError ? Colors.red : Colors.black,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(10),
    );

    return Material(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.translate(
                offset: Offset(xOffset, 0),
                child: TextField(
                  decoration: InputDecoration(
                    hintStyle:
                        TextStyle(color: hasError ? Colors.red : Colors.grey),
                    hintText: 'Shake me',
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  _controller.forward().then((_) {
                    setState(() {
                      hasError = false;
                    });
                    _controller.reset();
                  });
                  setState(() {
                    hasError = true;
                  });
                },
                child: Text('Shake'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
