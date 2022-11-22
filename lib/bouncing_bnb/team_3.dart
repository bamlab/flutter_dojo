import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class BouncingBNBTeam3 extends TeamWidget {
  const BouncingBNBTeam3({
    Key? key,
  }) : super(key: key, teamName: 'Team3');

  @override
  Widget build(BuildContext context) {
    return _BouncingBNB();
  }
}

class _BouncingBNB extends StatefulWidget {
  const _BouncingBNB({Key? key}) : super(key: key);

  @override
  State<_BouncingBNB> createState() => _BouncingBNBState();
}

class _BouncingBNBState extends State<_BouncingBNB> {
  int _selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final fractionPosition = _selectedIndex * 0.25 + 0.125;

    return Material(
      child: ColoredBox(
        color: Colors.purpleAccent,
        child: Column(
          children: [
            Expanded(
              child: Container(),
            ),
            Container(
              height: 100,
              child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 200),
                tween: Tween<double>(
                  begin: fractionPosition,
                  end: fractionPosition,
                ),
                builder: (context, value, child) {
                  return CustomPaint(
                    painter: _CurvedCutoutPainter(
                      fractionPosition: value,
                    ),
                    child: child,
                  );
                },
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => onItemTapped(0),
                        child: Icon(Icons.home),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => onItemTapped(1),
                        child: Icon(Icons.search),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => onItemTapped(2),
                        child: Icon(Icons.add),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => onItemTapped(3),
                        child: Icon(Icons.favorite_border),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Create a custom painter which draws a rectangle with a curves cutout
class _CurvedCutoutPainter extends CustomPainter {
  final double fractionPosition;
  final cutoutHeight = 100.0;
  final cutoutRadius = 25.0;

  _CurvedCutoutPainter({required this.fractionPosition});

  @override
  void paint(Canvas canvas, Size size) {
    final cutoutXPos = size.width * fractionPosition;
    final paint = Paint()..color = Colors.white;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(cutoutXPos - cutoutRadius * 2, 0)
      ..quadraticBezierTo(
        cutoutXPos - cutoutRadius * 1.5,
        0,
        cutoutXPos - cutoutRadius,
        cutoutHeight / 2,
      )
      ..quadraticBezierTo(
        cutoutXPos,
        cutoutHeight,
        cutoutXPos + cutoutRadius,
        cutoutHeight / 2,
      )
      ..quadraticBezierTo(
        cutoutXPos + cutoutRadius * 1.5,
        0,
        cutoutXPos + cutoutRadius * 2,
        0,
      )
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    ;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _CurvedCutoutPainter oldDelegate) {
    return oldDelegate.fractionPosition != fractionPosition;
  }
}
