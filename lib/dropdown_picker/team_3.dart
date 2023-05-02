import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class DropdownPickerTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<DropdownPickerTeam3> createState() => _DropdownPickerTeam3State();
}

const animationDuration = 300;
const itemHeight = 50.0;
const items = ['Easy', 'Medium', 'Hard', 'Expert'];

class _DropdownPickerTeam3State extends State<DropdownPickerTeam3> {
  @override
  Widget build(BuildContext context) {
    final totalHeight = itemHeight * items.length;

    return Material(
      color: Colors.black,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Center(
              child: Container(
                color: Colors.blueGrey,
                width: totalHeight,
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
  late var _selectedItem = items.first;
  var isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final translationToTop = itemHeight * (items.length / 2 - 1 / 2);
    final translationToCurrentItem =
        translationToTop - itemHeight * items.indexOf(_selectedItem);

    final totalHeight = itemHeight * items.length;

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
        child: TweenAnimationBuilder(
          duration: Duration(milliseconds: animationDuration),
          tween: Tween<double>(
            begin: 0,
            end: isExpanded ? totalHeight : itemHeight,
          ),
          builder: (context, translationValue, child) {
            return Stack(
              clipBehavior: Clip.antiAlias,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: animationDuration),
                  height: translationValue,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: child,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: items
                      .map(
                        (item) => _PickerItem(
                          title: item,
                          height: itemHeight,
                          onTap: () {
                            setState(() {
                              _selectedItem = item;
                              isExpanded = !isExpanded;
                            });
                          },
                        ),
                      )
                      .toList(),
                ),
              ],
            );
          },
          child: OverflowBox(
            maxHeight: double.infinity,
            child: SizedBox(),
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
