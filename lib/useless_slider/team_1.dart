import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class UselessSliderTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<UselessSliderTeam1> createState() => _UselessSliderTeam1State();
}

class _UselessSliderTeam1State extends State<UselessSliderTeam1> {
  double width = 100;
  double heigth = 100;

  final double area = 10000.0;

  @override
  void initState() {
    heigth = area / width;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: GestureDetector(
          onScaleUpdate: (scaleUpdateDetails) {
            print(scaleUpdateDetails);
            setState(() {
              width = width * scaleUpdateDetails.scale;
              heigth = area / width;
            });
          },
          child: Container(
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                child: Container(
                  width: width,
                  height: heigth,
                  color: Colors.black,
                ),
              ),
            ),
          )),
    );
  }
}
