import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class HoleCardsTeam2 extends TeamWidget {
  const HoleCardsTeam2({
    Key? key,
  }) : super(key: key, teamName: 'Team2');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _MyCardStack(),
      ),
    );
  }
}

class _MyCardStack extends StatefulWidget {
  const _MyCardStack({Key? key}) : super(key: key);

  @override
  State<_MyCardStack> createState() => _MyCardStackState();
}

class _MyCardStackState extends State<_MyCardStack> {
  double position = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipPath(
          clipper: CustomPath(),
          child: SizedBox(
            width: 200,
            height: 300,
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: Duration(milliseconds: 900),
                  top: position,
                  child: _Card(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 200),
        Align(
          alignment: Alignment.bottomCenter,
          child: MaterialButton(
            onPressed: (() {
              setState(() {
                position = position == 0 ? 300 : 0;
              });
            }),
            child: Text('Click me'),
          ),
        )
      ],
    );
  }
}

class CustomPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width / 2, size.height - size.height / 3);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}

class _Card extends StatelessWidget {
  const _Card({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.red,
      child: SizedBox(
        width: 200,
        height: 200,
      ),
    );
  }
}
