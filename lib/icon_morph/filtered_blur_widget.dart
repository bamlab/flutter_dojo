import 'package:bam_dojo/hero_list/team_1.dart';
import 'package:flutter/material.dart';

class FilteredBlur extends StatelessWidget {
  const FilteredBlur({super.key, required this.child, required this.blur});

  final Widget child;
  final double blur;

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
        colorFilter: ColorFilter.matrix(
          [
            1, 0, 0, 0, 0, //
            0, 1, 0, 0, 0, //
            0, 0, 1, 0, 0, //
            0, 0, 0, 255, 0, //
          ],
        ),
        child: ColorFiltered(
            colorFilter: ColorFilter.matrix(
              [
                1, 0, 0, 0, 0, //
                0, 1, 0, 0, 0, //
                0, 0, 1, 0, 0, //
                0, 0, 0, 1, -255 / 2, //
              ],
            ),
            child: BlurredWidget(blur: blur, child: child)));
  }
}
