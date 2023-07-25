import 'package:bam_dojo/helpers/team_class.dart';
import 'package:bam_dojo/rounded%20carousel/rounded%20carousel.dart';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class RoundedCarouselTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<RoundedCarouselTeam1> createState() => _RoundedCarouselTeam1State();
}

class _RoundedCarouselTeam1State extends State<RoundedCarouselTeam1> {
  final _controller = PageController(viewportFraction: 0.6);
  var _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentIndex = _controller.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.pink[100],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.elliptical(
                                MediaQuery.of(context).size.height / 4, 70),
                            topRight: Radius.elliptical(
                                MediaQuery.of(context).size.height / 4, 70),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: PageView.builder(
                controller: _controller,
                itemBuilder: (context, index) {
                  return Center(
                    child: AnimatedContainer(
                      transform: Matrix4.translation(
                        vector.Vector3(
                          0.0,
                          index == _currentIndex ? -80 : 40,
                          0.0,
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              roundedCarouselImages[index],
                            ),
                          )),
                      duration: const Duration(milliseconds: 300),
                      height: index == _currentIndex ? 300 : 200,
                      width: 200,
                    ),
                  );
                },
                itemCount: roundedCarouselImages.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
