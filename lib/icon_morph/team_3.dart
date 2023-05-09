import 'package:bam_dojo/helpers/team_class.dart';
import 'package:bam_dojo/icon_morph/filtered_blur_widget.dart';
import 'package:flutter/material.dart';

class IconMorphTeam3 extends TeamWidget {
  const IconMorphTeam3({
    Key? key,
  }) : super(key: key, teamName: 'Team3');

  @override
  Widget build(BuildContext context) {
    return _IconsSelector();
  }
}

class _IconsSelector extends StatefulWidget {
  @override
  _IconsSelectorState createState() => _IconsSelectorState();
}

class _IconsSelectorState extends State<_IconsSelector>
    with TickerProviderStateMixin {
  final _selectableIcons = [
    Icons.square,
    Icons.circle,
    Icons.add,
    Icons.add_a_photo,
    Icons.add_alert,
    Icons.add_box,
    Icons.pause_rounded,
    Icons.person,
    Icons.hourglass_bottom,
    Icons.hourglass_top,
  ];

  late var _selectedIcon = _selectableIcons.first;
  IconData? _previouslySelectedIcon;

  final animationDuration = Duration(milliseconds: 500);

  late final blurAnimationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: (animationDuration.inMilliseconds) ~/ 4),
  );

  @override
  void initState() {
    super.initState();

    blurAnimationController.addListener(() {
      setState(() {});
    });
  }

  Widget buildIconSelector({required IconData icon}) {
    return _IconSelector(
      icon: icon,
      selected: _selectedIcon == icon,
      onTap: () async {
        if (mounted) {
          setState(() {
            _previouslySelectedIcon = _selectedIcon;
            _selectedIcon = icon;
          });
        }

        await blurAnimationController.forward();

        await Duration(milliseconds: animationDuration.inMilliseconds ~/ 2);
        // unblur
        blurAnimationController.reverse();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final previouslySelectedIcon = _previouslySelectedIcon;

    return Scaffold(
      appBar: AppBar(
        title: Text('Icon Morph'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilteredBlur(
              blur: blurAnimationController.value,
              child: Stack(
                children: [
                  if (previouslySelectedIcon != null)
                    TweenAnimationBuilder(
                      key: ValueKey(previouslySelectedIcon),
                      duration: animationDuration,
                      tween: Tween<double>(begin: 1, end: 0),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: child,
                        );
                      },
                      child: Icon(previouslySelectedIcon, size: 100),
                    ),
                  TweenAnimationBuilder(
                    key: ValueKey(_selectedIcon),
                    duration: animationDuration,
                    tween: Tween<double>(begin: 0, end: 1),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: child,
                      );
                    },
                    child: Icon(_selectedIcon, size: 100),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            GridView(
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              children: _selectableIcons
                  .map((icon) => Center(child: buildIconSelector(icon: icon)))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconSelector extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _IconSelector({
    Key? key,
    required this.icon,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: selected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),
        ),
        child: Icon(
          icon,
          color: selected ? Colors.white : Colors.blue,
        ),
      ),
    );
  }
}
