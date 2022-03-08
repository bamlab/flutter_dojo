import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class AirTagsAnimationTeam2 extends TeamWidget {
  const AirTagsAnimationTeam2({
    Key? key,
  }) : super(key: key, teamName: 'Valentin & Lucas');

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: AirTagsPageView(),
      ),
    );
  }
}

class AirTagsPageView extends StatefulWidget {
  const AirTagsPageView({Key? key}) : super(key: key);

  @override
  State<AirTagsPageView> createState() => _AirTagsPageViewState();
}

class _AirTagsPageViewState extends State<AirTagsPageView> {
  final _controller = PageController(viewportFraction: 0.4);

  double get page =>
      _controller.positions.isNotEmpty == true ? _controller.page ?? 0 : 0.0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_listener);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_listener);
  }

  _listener() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: PageView(
        controller: _controller,
        children: [
          AirTagItem(
            icon: Icons.access_alarm_outlined,
            title: 'Devices',
            isSelected: page.floor() == 0,
          ),
          AirTagItem(
            icon: Icons.abc,
            title: 'Items',
            isSelected: page.floor() == 1,
          ),
          AirTagItem(
            icon: Icons.person,
            title: 'Dogs',
            isSelected: page.floor() == 2,
          ),
          AirTagItem(
            icon: Icons.edit,
            title: 'Others',
            isSelected: page.floor() == 3,
          ),
        ],
      ),
    );
  }
}

class AirTagItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;

  const AirTagItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, isSelected ? -20 : 0),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 50,
          width: 50,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.red,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}
