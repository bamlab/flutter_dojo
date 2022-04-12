import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class AirTagsAnimationTeam1 extends TeamWidget {
  const AirTagsAnimationTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Louis & GuillaumeB');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _Text(),
              _SelectableList(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Text extends StatelessWidget {
  const _Text({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Text(
        'Browse',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
}

final listTitles = ['Devices', 'Items', 'People', 'Places'];

class _SelectableList extends StatefulWidget {
  const _SelectableList({Key? key}) : super(key: key);

  @override
  State<_SelectableList> createState() => _SelectableListState();
}

class _SelectableListState extends State<_SelectableList> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: List.generate(
          listTitles.length,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: _SelectableCard(
              isSelected: index == selectedIndex,
              title: listTitles[index],
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectableCard extends StatefulWidget {
  const _SelectableCard({
    Key? key,
    required this.isSelected,
    required this.title,
  }) : super(key: key);
  final bool isSelected;
  final String title;

  @override
  State<_SelectableCard> createState() => __SelectableCardState();
}

class __SelectableCardState extends State<_SelectableCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 250),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0, -12),
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ),
  );

  late final Animation<Color?> _colorAnimation = ColorTween(
    begin: Colors.white,
    end: Colors.black,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ),
  );

  late final Animation<Color?> _textColorAnimation = ColorTween(
    begin: Colors.black,
    end: Colors.white,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ),
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
    if (widget.isSelected) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _SelectableCard oldWidget) {
    if (oldWidget.isSelected != widget.isSelected) {
      if (widget.isSelected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: _offsetAnimation.value,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: _colorAnimation.value,
            borderRadius: BorderRadius.circular(8),
          ),
          height: 100,
          width: 100,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(color: _textColorAnimation.value),
                ),
                const SizedBox(
                  height: 8,
                ),
                Icon(
                  Icons.devices,
                  color: _textColorAnimation.value,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
