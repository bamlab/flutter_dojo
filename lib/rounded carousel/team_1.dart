import 'package:bam_dojo/helpers/team_class.dart';
import 'package:bam_dojo/rounded%20carousel/rounded%20carousel.dart';
import 'package:collection/collection.dart';

import 'package:flutter/material.dart';

class RoundedCarouselTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<RoundedCarouselTeam1> createState() => _RoundedCarouselTeam1State();
}

class _RoundedCarouselTeam1State extends State<RoundedCarouselTeam1> {
  final _controller = PageController(viewportFraction: 0.6);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: PageView(
          controller: _controller,
          children: roundedCarouselImages
              .mapIndexed(
                (index, imageUrl) => Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      imageUrl,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
