import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class SignUpTeam1 extends TeamWidget {
  const SignUpTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Guillaumes');

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.red,
      body: _ShowBottom(),
    );
  }
}

class _ShowBottom extends StatefulWidget {
  const _ShowBottom({Key? key}) : super(key: key);

  @override
  State<_ShowBottom> createState() => _ShowBottomState();
}

class _ShowBottomState extends State<_ShowBottom> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(42),
            topRight: Radius.circular(42),
          ),
        ),
        builder: (_) => const _Sheet(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _Sheet extends StatefulWidget {
  const _Sheet({Key? key}) : super(key: key);

  @override
  State<_Sheet> createState() => _SheetState();
}

class _SheetState extends State<_Sheet> with SingleTickerProviderStateMixin {
  late final animationController = AnimationController(
    duration: const Duration(milliseconds: 250),
    vsync: this,
  );

  double opacity = 0;

  late final tween = Tween<double>(begin: 0, end: 180).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    ),
  );

  @override
  void initState() {
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Find local community events",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),
          ),
          const SizedBox(
            height: 120,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              height: 72,
              child: FloatingActionButton.extended(
                onPressed: () {
                  animationController.forward();
                  setState(() {
                    opacity = 1;
                  });
                },
                label: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Get started'),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 60 + tween.value,
            child: AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(milliseconds: 250),
              child: const Align(
                alignment: Alignment.bottomLeft,
                child: Text('Coucou'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
