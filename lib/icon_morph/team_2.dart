import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class IconMorphTeam2 extends TeamWidget {
  const IconMorphTeam2({
    Key? key,
  }) : super(key: key, teamName: 'Team2');

  @override
  Widget build(BuildContext context) {
    return _IconsSelector();
  }
}

class _IconsSelector extends StatefulWidget {
  @override
  _IconsSelectorState createState() => _IconsSelectorState();
}

class _IconsSelectorState extends State<_IconsSelector> {
  final _selectableIcons = [
    Icons.ac_unit,
    Icons.access_time,
    Icons.add,
    Icons.add_a_photo,
    Icons.add_alert,
    Icons.add_box,
    Icons.percent_outlined,
    Icons.person,
    Icons.hourglass_bottom,
    Icons.hourglass_top,
  ];

  late var _selectedIcon = _selectableIcons.first;

  Widget buildIconSelector({required IconData icon}) {
    return _IconSelector(
      icon: icon,
      selected: _selectedIcon == icon,
      onTap: () => setState(() => _selectedIcon = icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Morph between icons. Get inspiration from lib/refresh_plus/team_1.dart
    return Scaffold(
      appBar: AppBar(
        title: Text('Icon Morph'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(_selectedIcon, size: 100),
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
