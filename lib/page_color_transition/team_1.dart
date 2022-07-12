import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:bam_dojo/page_color_transition/page_color_transition.dart';
import 'package:flutter/material.dart';

class PageColorTransitionTeam1 extends TeamWidget {
  const PageColorTransitionTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Team1');

  @override
  Widget build(BuildContext context) {
    return Material(
      child: _Swiper(),
    );
  }
}

class _Swiper extends StatefulWidget {
  const _Swiper({Key? key}) : super(key: key);

  @override
  State<_Swiper> createState() => _SwiperState();
}

class _SwiperState extends State<_Swiper> {
  Offset _dragOffset = Offset.zero;
  final pageController = PageController(initialPage: 0);

  int pageIndex = 0;
  double pageOffset = 0;

  initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        if (pageController.positions.isNotEmpty) {
          final page = pageController.page;
          if (page != null) {
            pageOffset = page % 1;
            pageIndex = min(
              DojoPageColorTransition.pagesData.length,
              max(0, pageOffset > 0.5 ? page.ceil() : page.floor()),
            );
            print('pageOffset: $pageOffset');
            print('pageIndex: $pageIndex');
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentPage = DojoPageColorTransition.pagesData[pageIndex];

    final initialOffset = Offset(0, 0.8);
    final endOffset = Offset(79.2, 0);

    final initialRadius = 50.0;

    final endScale = 260.0;

    final scaleTween = Tween<double>(begin: 1, end: endScale)
        .chain(CurveTween(curve: Curves.easeIn))
        .evaluate(AlwaysStoppedAnimation(pageOffset));

    final alignXTween = Tween<double>(begin: 0, end: endOffset.dx)
        .chain(CurveTween(curve: Curves.easeIn))
        .evaluate(AlwaysStoppedAnimation(pageOffset));

    return Stack(
      children: [
        ColoredBox(
          color: currentPage.primaryColor,
          child: SizedBox.expand(),
        ),
        Align(
          alignment: Alignment(
            alignXTween,
            initialOffset.dy * (1 - pageOffset) + endOffset.dy * pageOffset,
          ),
          // A circle
          child: Transform.scale(
            // The first "1" is because the initial scale is 1
            scale: scaleTween,
            child: Container(
              width: initialRadius * 2,
              height: initialRadius * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
            ),
          ),
        ),
        PageView(
          controller: pageController,
          children: DojoPageColorTransition.pagesData
              .map(
                (pageData) => Center(
                  child: pageData.iconBuilder(
                    MediaQuery.of(context).size.width * 0.5,
                  ),
                ),
              )
              .toList(),
          // child: GestureDetector(
          //   behavior: HitTestBehavior.opaque,
          //   onHorizontalDragUpdate: (details) {
          //     setState(() {
          //       _dragOffset += details.delta;
          //       print(_dragOffset);
          //     });
          //   },
          //   child: ColoredBox(
          //     color: DojoPageColorTransition.pagesData[0].primaryColor,
          //     child: Stack(
          //       children: [
          //         Positioned(
          //           bottom: 100,
          //           right: center - radius + _dragOffset.dx,
          //           // A circle
          //           child: Container(
          //             width: radius * 2,
          //             height: radius * 2,
          //             decoration: BoxDecoration(
          //               shape: BoxShape.circle,
          //               color: DojoPageColorTransition.pagesData[1].primaryColor,
          //             ),
          //           ),
          //         ),
          //         Center(
          //           child: DojoPageColorTransition.pagesData[1].iconBuilder(
          //             MediaQuery.of(context).size.width * 0.5,
          //           ),
          //         ),
          //         Align(
          //           alignment: Alignment.bottomCenter,
          //           child: FloatingActionButton(
          //             onPressed: () {
          //               setState(() {
          //                 _dragOffset = Offset.zero;
          //               });
          //             },
          //             child: Icon(Icons.refresh),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ),
      ],
    );
  }
}
