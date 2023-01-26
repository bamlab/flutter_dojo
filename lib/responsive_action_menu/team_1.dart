import 'package:bam_dojo/helpers/team_class.dart';
import 'package:bam_dojo/responsive_action_menu/responsive_action_menu.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

final columnKey = GlobalKey();

class ResponsiveActionMenuTeam1 extends TeamWidget {
  const ResponsiveActionMenuTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Team1');

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              "https://images.unsplash.com/photo-1568826069038-f3de1448e9a1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=922&q=80",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white.withOpacity(0.8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: _Column(
                  key: columnKey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Column extends StatefulWidget {
  const _Column({
    Key? key,
  }) : super(key: key);

  @override
  State<_Column> createState() => _ColumnState();
}

class _ColumnState extends State<_Column> {
  int? _selectedIndex = null;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: buildSeparated(
        DojoResponsiveActionMenu.users.mapIndexed((index, user) {
          final isSelected = _selectedIndex == index;
          return AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: isSelected ? 1.3 : 1,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              onPanUpdate: (details) {
                final position = details.globalPosition;
                final height = MediaQuery.of(context).size.height;

                final RenderBox renderBox =
                    columnKey.currentContext!.findRenderObject() as RenderBox;
                final columnHeight = renderBox.localToGlobal(Offset.zero).dy;

                final index = (position.dy - columnHeight) / height * 10;
                // Explanation:
                // 1. We get the position of the tap
                // 2. We get the height of the screen
                // 3. We get the offset of the column
                // 4. We calculate the index of the user by dividing the position of the tap by the height of the screen

                setState(() {
                  _selectedIndex = index.round();
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:
                      isSelected ? Colors.white : Colors.white.withOpacity(0),
                ),
                child: UserListTileBody(user: user),
              ),
            ),
          );
        }),
        separator: const SizedBox(height: 20),
      ),
    );
  }
}
