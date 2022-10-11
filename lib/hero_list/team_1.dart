import 'dart:ui';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:equatable/equatable.dart';
import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeroListTeam1 extends StatelessWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: _SearchList(),
    );
  }
}

class _SearchList extends StatefulWidget {
  const _SearchList({Key? key}) : super(key: key);

  @override
  State<_SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<_SearchList> {
  final cardDataList = List.generate(
    50,
    (index) {
      final name = faker.person.name();
      return _CardData(
        color: Colors.primaries[index % Colors.primaries.length],
        name: name,
        // Random avatar image
        imageUrl: 'https://avatars.dicebear.com/api/adventurer/$name.png',
      );
    },
  );
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: CupertinoTextField(
                scrollPadding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(50),
                  borderRadius: BorderRadius.circular(20),
                ),
                prefix: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.search, color: Colors.grey),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                controller: controller,
              ),
            ),
          ),
        ),
        Expanded(
          child: _CardsList(
            searchedText: controller.text,
            dataList: cardDataList,
          ),
        ),
      ],
    );
  }
}

class _CardsList extends StatefulWidget {
  _CardsList({
    Key? key,
    required this.dataList,
    required this.searchedText,
  }) : super(key: key);

  final List<_CardData> dataList;
  final searchedText;

  @override
  State<_CardsList> createState() => _CardsListState();
}

class _CardsListState extends State<_CardsList> {
  final cardsByLine = 3;

  @override
  void initState() {
    super.initState();

    _updateFilteredDataList();
  }

  @override
  void didUpdateWidget(covariant _CardsList oldWidget) {
    super.didUpdateWidget(oldWidget);

    _updateFilteredDataList();
  }

  void _updateFilteredDataList() {
    previousFilteredDataList = filteredDataList;
    filteredDataList = widget.dataList
        .where((element) =>
            widget.searchedText.isEmpty ||
            element.name
                .toLowerCase()
                .contains(widget.searchedText.toLowerCase()))
        .toList();
  }

  List<_CardData> filteredDataList = [];

  List<_CardData> previousFilteredDataList = [];

  final maxBlur = 5.0;
  final inOutAnimationDuration = Duration(milliseconds: 500);
  final translationAnimationDuration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      final cardWidth = constraints.maxWidth / cardsByLine;
      final cardHeight = cardWidth;

      final bottomPadding = MediaQuery.of(context).padding.bottom;

      return SingleChildScrollView(
        child: SizedBox(
          height: cardHeight * (filteredDataList.length / cardsByLine).ceil() +
              bottomPadding,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              for (var i = 0; i < widget.dataList.length; i++)
                () {
                  final cardData = widget.dataList[i];

                  final visibleIndex = filteredDataList.indexOf(cardData);
                  final isVisible = visibleIndex != -1;

                  final previousVisibleIndex =
                      previousFilteredDataList.indexOf(cardData);
                  final wasVisible = previousVisibleIndex != -1;

                  // Put what isn't visible at the start of the list so that
                  // these items appear bellow the others
                  if (!isVisible) {
                    if (wasVisible) {
                      return AnimatedPositioned(
                        duration: translationAnimationDuration,
                        key: ValueKey(i),
                        left: (previousVisibleIndex % cardsByLine) * cardWidth,
                        top: (previousVisibleIndex ~/ cardsByLine) * cardHeight,
                        height: cardHeight,
                        width: cardWidth,
                        child: TweenAnimationBuilder<double>(
                          duration: inOutAnimationDuration,
                          tween: Tween(begin: 1, end: 0),
                          builder: (_, value, child) {
                            return BlurredWidget(
                              blur: value * maxBlur,
                              child: Opacity(opacity: value, child: child),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _Card(data: cardData),
                          ),
                        ),
                      );
                    }

                    return Positioned(
                      key: ValueKey(i),
                      height: 0,
                      width: 0,
                      child: SizedBox.shrink(),
                    );
                  }

                  return AnimatedPositioned(
                    key: ValueKey(i),
                    duration: translationAnimationDuration,
                    left: (visibleIndex % cardsByLine) * cardWidth,
                    top: (visibleIndex ~/ cardsByLine) * cardHeight,
                    height: cardHeight,
                    width: cardWidth,
                    child: TweenAnimationBuilder<double>(
                      duration: inOutAnimationDuration,
                      tween: Tween(begin: 0, end: 1),
                      builder: (_, value, child) {
                        return BlurredWidget(
                          blur: (1 - value) * maxBlur,
                          child: Opacity(opacity: value, child: child),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _Card(data: cardData),
                      ),
                    ),
                  );
                }(),
            ],
          ),
        ),
      );
    });
  }
}

class _CardData extends Equatable {
  _CardData({
    required this.color,
    required this.name,
    required this.imageUrl,
  });

  final Color color;
  final String name;
  final String imageUrl;

  @override
  List<Object?> get props => [name];
}

class _Card extends StatelessWidget {
  const _Card({
    Key? key,
    required this.data,
  }) : super(key: key);

  final _CardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: data.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(child: Image.network(data.imageUrl, fit: BoxFit.cover)),
          SizedBox(height: 8),
          Center(
            child: Text(
              data.name,
              style: TextStyle(color: data.color),
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class BlurredWidget extends StatelessWidget {
  const BlurredWidget({Key? key, required this.blur, required this.child})
      : super(key: key);

  final double blur;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: <Widget>[
          child,
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
              child: Container(color: Colors.transparent),
            ),
          )
        ],
      ),
    );
  }
}
