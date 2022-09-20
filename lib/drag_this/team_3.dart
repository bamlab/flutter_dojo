import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class DragThisTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<DragThisTeam3> createState() => _DragThisTeam3State();
}

class _DragThisTeam3State extends State<DragThisTeam3> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: PageView.builder(
        controller: controller,
        itemBuilder: (context, index) {
          return _Page(
            controller: controller,
            index: index,
          );
        },
        itemCount: 50,
      ),
    );
  }
}

class _Page extends StatelessWidget {
  const _Page({
    Key? key,
    required this.controller,
    required this.index,
  }) : super(key: key);

  final PageController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 400,
        width: 300,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                _RandomImage(controller: controller, index: index),
                Expanded(child: SizedBox()),
                SizedBox(height: 10),
                const _RandomTitle(),
                SizedBox(height: 10),
                const _RandomArtistName(),
                SizedBox(height: 10),
                const _RandomStars(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RandomImage extends StatefulWidget {
  const _RandomImage({
    Key? key,
    required this.controller,
    required this.index,
  }) : super(key: key);

  final PageController controller;
  final int index;

  @override
  State<_RandomImage> createState() => _RandomImageState();
}

class _RandomImageState extends State<_RandomImage> {
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Between -1 and 1, -1 is left, 1 is right
    final offset = (widget.controller.offset / (screenWidth) - widget.index)
        .clamp(-1, 1)
        .toDouble();

    return ClipOval(
      child: Transform.scale(
        scale: -offset.abs() + 1.5,
        child: Image.network(
          'https://picsum.photos/200/200?index=${widget.index}',
          fit: BoxFit.fill,
          height: 200,
          width: 200,
          // cacheKey: widget.index.toString(),
        ),
      ),
    );
  }
}

class _RandomTitle extends StatelessWidget {
  const _RandomTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      Faker().food.dish(),
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }
}

class _RandomArtistName extends StatelessWidget {
  const _RandomArtistName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(Faker().person.name());
  }
}

class _RandomStars extends StatefulWidget {
  const _RandomStars({Key? key}) : super(key: key);

  @override
  State<_RandomStars> createState() => _RandomStarsState();
}

class _RandomStarsState extends State<_RandomStars> {
  final starsCount = Random().nextInt(5) + 1;
  @override
  Widget build(BuildContext context) {
    // A row of 5 starts, with a random number of them filled
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) => Icon(
          Icons.star,
          color: index < starsCount ? Colors.yellow : Colors.grey[200],
        ),
      ),
    );
  }
}
