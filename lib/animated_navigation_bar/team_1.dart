import 'package:bam_dojo/helpers/team_class.dart';

import 'package:flutter/material.dart';

class AnimatedNavigationBarTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<AnimatedNavigationBarTeam1> createState() =>
      _AnimatedNavigationBarTeam1State();
}

class _AnimatedNavigationBarTeam1State extends State<AnimatedNavigationBarTeam1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 150),
    vsync: this,
  );
  late Tween<double> _tween = Tween(begin: 0.0, end: 0.0);

  var index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int newIndex) {
      setState(() {
        _tween = Tween(
            begin: _tween.evaluate(_controller), end: newIndex.toDouble());
        index = newIndex;
      });
      _controller.forward(from: 0.0);
    }

    final width = MediaQuery.of(context).size.width;
    final icon = switch (index) {
      0 => Icons.home,
      1 => Icons.person,
      2 => Icons.settings,
      _ => Icons.home,
    };

    return MaterialApp(
      home: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red,
              Colors.blue,
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return Stack(
                children: [
                  SizedBox(
                    height: 130,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ClipPath(
                        clipper: BottomNavClipper(
                            animationValue: _tween.evaluate(_controller)),
                        child: BottomNavigationBar(
                          iconSize: 44,
                          items: [
                            BottomNavigationBarItem(
                              icon: Icon(Icons.home),
                              label: index == 0 ? '' : 'Home',
                              activeIcon: SizedBox.shrink(),
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.person),
                              label: index == 1 ? '' : 'Profile',
                              activeIcon: SizedBox.shrink(),
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.settings),
                              label: index == 2 ? '' : 'Settings',
                              activeIcon: SizedBox.shrink(),
                            ),
                          ],
                          currentIndex: index,
                          onTap: _onItemTapped,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: _tween.evaluate(_controller) * width / 3,
                    child: SizedBox(
                      width: width / 3,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 150),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                            child: Icon(
                              key: ValueKey(icon),
                              icon,
                              size: 44,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class BottomNavClipper extends CustomClipper<Path> {
  BottomNavClipper({required this.animationValue});

  final double animationValue;
  @override
  Path getClip(Size size) {
    final path = Path();
    final height = size.height;
    final width = size.width;
    final xStart = animationValue * width / 3;
    final partLength = width / 6;

    path.lineTo(0, 0);
    path.lineTo(xStart, 0);
    final b1 = 0.5;
    final b2 = 0.1;

    path.cubicTo(
      xStart + b1 * partLength,
      0,
      xStart + partLength * b2,
      4 * partLength / 5,
      xStart + partLength,
      4 * partLength / 5,
    );

    path.cubicTo(
      xStart + partLength + partLength * (1 - b2),
      4 * partLength / 5,
      xStart + partLength + partLength * (1 - b1),
      0,
      xStart + 2 * partLength,
      0,
    );

    path.lineTo(width, 0);
    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(BottomNavClipper oldClipper) {
    print(animationValue);
    return true;
  }
}
