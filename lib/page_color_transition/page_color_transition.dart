import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

/// Design: https://dribbble.com/shots/10792593-Pulsating-cubes

final _teams = <TeamWidget>[
  const PageColorTransitionTeam1(),
  const PageColorTransitionTeam2(),
  const PageColorTransitionTeam3(),
];

class DojoPageColorTransition extends DojoWidget {
  DojoPageColorTransition({
    Key? key,
  }) : super(key: key, dojoName: 'Page Color Transition', teams: _teams);

  static final pagesData = <PageData>[
    PageData(
      titleString: 'Choose your interests',
      primaryColor: Color(0xFF2569D8),
      iconSvgAsset:
          'assets/page_color_transition/icons/choose_your_interests.svg',
    ),
    PageData(
      titleString: 'Local news stories',
      primaryColor: Color(0xFFFF8CAB),
      iconSvgAsset: 'assets/page_color_transition/icons/local_news_stories.svg',
    ),
    PageData(
      titleString: 'Save news stories',
      primaryColor: Color(0xFFFDFDFD),
      iconSvgAsset: 'assets/page_color_transition/icons/save_news_stories.svg',
    ),
  ];
}

class PageData {
  final Widget title;
  final Color primaryColor;
  final Widget Function(double size) iconBuilder;

  PageData({
    required String titleString,
    required this.primaryColor,
    required String iconSvgAsset,
  })  : title = Text(
          titleString,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconBuilder = ((size) => SvgPicture.asset(
              iconSvgAsset,
              height: size,
              width: size,
            ));
}
