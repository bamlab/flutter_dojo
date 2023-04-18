import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class DropdownPickerTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<DropdownPickerTeam3> createState() => _DropdownPickerTeam3State();
}

class _DropdownPickerTeam3State extends State<DropdownPickerTeam3> {
  final items = ['Easy', 'Medium', 'Hard', 'Expert'];

  late var _selectedItem = items.first;
  var isExpanded = true;
  final itemHeight = 50.0;

  @override
  Widget build(BuildContext context) {
    final translationToTop = itemHeight * (items.length / 2 - 1 / 2);
    final translationToCurrentItem =
        translationToTop - itemHeight * items.indexOf(_selectedItem);

    final totalHeight = itemHeight * items.length;

    return Material(
      color: Colors.black,
      child: Center(
        child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 300),
          tween: Tween<double>(
            begin: 0,
            end: isExpanded ? translationToCurrentItem : 0,
          ),
          builder: (context, translationValue, child) {
            return Transform.translate(
              offset: Offset(0, translationValue),
              child: child,
            );
          },
          child: SizedBox(
            width: totalHeight,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isExpanded ? totalHeight : itemHeight,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: OverflowBox(
                alignment: Alignment(
                  0,
                  2 / 3 * items.indexOf(_selectedItem) - 1,
                ),
                maxHeight: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: items
                      .map(
                        (item) => _PickerItem(
                          title: item,
                          height: itemHeight,
                          isSelected: item == _selectedItem,
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
              ),
            ),
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
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final double height;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        color: isSelected ? Colors.blueGrey : Colors.grey,
        child: Center(
          child: Text(title),
        ),
      ),
    );
  }
}
