import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class AirTagsAnimationTeam3 extends TeamWidget {
  const AirTagsAnimationTeam3({
    Key? key,
  }) : super(key: key, teamName: 'Vincent & GuillaumeDM');

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: ListOfCards()),
    );
  }
}

class ListOfCards extends StatefulWidget {
  const ListOfCards({Key? key}) : super(key: key);

  @override
  State<ListOfCards> createState() => _ListOfCardsState();
}

class _ListOfCardsState extends State<ListOfCards> {
  int _currrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 300),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            ...List.generate(
                5,
                (index) => MyCard(
                      onTap: (() {
                        setState(() {
                          _currrentIndex = index;
                        });
                      }),
                      isSelected: index == _currrentIndex,
                    ))
          ],
        ));
  }
}

class MyCard extends StatelessWidget {
  const MyCard({Key? key, this.isSelected = false, this.onTap})
      : super(key: key);

  final VoidCallback? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        children: [
          AnimatedPositioned(
            height: 200,
            width: 200,
            duration: const Duration(milliseconds: 100),
            top: isSelected ? 0 : 50,
            child: InkWell(
              onTap: onTap,
              child: SizedBox(
                // width: 200,
                // height: 200,
                child: Card(
                    color: isSelected ? Colors.amber : Colors.red,
                    child: const Center(child: Text("Hello"))),
              ),
            ),
          )
        ],
      ),
    );
  }
}
