import 'package:bam_dojo/helpers/team_class.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class DropdownPickerTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<DropdownPickerTeam1> createState() => _DropdownPickerTeam1State();
}

const animationDuration = 200;
const itemWidth = 200.0;
const itemHeight = 50.0;
const items = const ['Easy', 'Medium', 'Hard', 'Expert'];
final totalHeight = itemHeight * items.length;

class _DropdownPickerTeam1State extends State<DropdownPickerTeam1> {
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
          _Picker(),
        ],
      ),
    );
  }
}

class _Picker extends StatefulWidget {
  const _Picker();

  @override
  State<_Picker> createState() => _PickerState();
}

class _PickerState extends State<_Picker> {
  late var _selectedIndex = 0;
  var isExpanded = false;

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
            child: TweenAnimationBuilder(
              duration: Duration(milliseconds: animationDuration),
              tween: Tween<double>(
                begin: isExpanded ? itemHeight * _selectedIndex : 0,
                end: isExpanded ? 0 : itemHeight * _selectedIndex,
              ),
              builder: (context, clipOffset, child) {
                return TweenAnimationBuilder(
                  duration: Duration(milliseconds: animationDuration),
                  tween: Tween(
                    begin: isExpanded ? itemHeight : totalHeight,
                    end: isExpanded ? totalHeight : itemHeight,
                  ),
                  builder: (context, clipValue, child) {
                    return ClipRect(
                      clipper: _PickerClipper(
                        clipHeight: clipValue,
                        clipOffset: clipOffset,
                      ),
                      child: child,
                    );
                  },
                  child: ColoredBox(
                    color: Colors.grey,
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
                );
              },
            ),
          );
        },
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
        width: itemWidth,
        height: height,
        child: Center(
          child: Text(title, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

class _PickerClipper extends CustomClipper<Rect> {
  final double clipHeight;
  final double clipOffset;

  _PickerClipper({
    required this.clipOffset,
    required this.clipHeight,
  });

  @override
  Rect getClip(Size size) {
    final offset = Offset(
      (size.width - itemWidth) / 2,
      clipOffset,
    );

    final correctedSize = Size(200, clipHeight);

    return offset & correctedSize;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}
