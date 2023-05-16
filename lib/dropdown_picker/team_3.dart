import 'package:bam_dojo/helpers/team_class.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class DropdownPickerTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<DropdownPickerTeam3> createState() => _DropdownPickerTeam3State();
}

const animationDuration = 200;
const itemWidth = 200.0;
const itemHeight = 50.0;
const items = ['Easy', 'Medium', 'Hard', 'Expert'];

class _DropdownPickerTeam3State extends State<DropdownPickerTeam3> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Center(
              child: Container(
                color: Colors.blueGrey,
                width: itemWidth,
                height: itemHeight,
              ),
            ),
          ),
          Scroller(
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}

class Scroller extends StatefulWidget {
  const Scroller({super.key, required this.child});
  final Widget child;

  @override
  State<Scroller> createState() => _ScrollerState();
}

class _ScrollerState extends State<Scroller> {
  late var _selectedIndex = 0;
  var isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final translationToTop = itemHeight * (items.length / 2 - 1 / 2);
    final translationToCurrentItem =
        translationToTop - itemHeight * _selectedIndex;

    return Center(
      child: TweenAnimationBuilder(
        duration: Duration(milliseconds: animationDuration),
        tween: Tween<double>(
          begin: translationToCurrentItem,
          end: translationToCurrentItem,
        ),
        builder: (context, translationValue, child) {
          return Transform.translate(
            offset: Offset(0, translationValue),
            child: child,
          );
        },
        child: ClipRect(
          clipper: _PickerClipper(
            selectedIndex: _selectedIndex,
            isExpanded: isExpanded,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: items
                .mapIndexed(
                  (index, item) => _PickerItem(
                    title: item,
                    height: itemHeight,
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                        isExpanded = !isExpanded;
                      });
                    },
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class _PickerItem extends StatelessWidget {
  _PickerItem({
    required this.title,
    required this.height,
    required this.onTap,
  });

  final String title;
  final double height;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        height: height,
        child: Center(
          child: Text(title, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

class _PickerClipper extends CustomClipper<Rect> {
  final int selectedIndex;
  final bool isExpanded;

  _PickerClipper({
    required this.selectedIndex,
    required this.isExpanded,
  });

  @override
  Rect getClip(Size size) {
    final offset = Offset(
      (size.width - itemWidth) / 2,
      isExpanded ? 0 : selectedIndex * itemHeight,
    );

    final correctedSize = isExpanded ? size : Size(200, itemHeight);

    return offset & correctedSize;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}
