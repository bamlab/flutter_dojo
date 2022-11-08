import 'package:bam_dojo/helpers/team_class.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

class HeroNoHeroTeam1 extends StatefulWidget with TeamMixin {
  const HeroNoHeroTeam1({
    Key? key,
  }) : super(key: key);

  @override
  String get teamName => 'Team1';

  @override
  State<HeroNoHeroTeam1> createState() => _HeroNoHeroTeam1State();
}

class _HeroNoHeroTeam1State extends State<HeroNoHeroTeam1> {
  String? selectedLetter;

  @override
  Widget build(BuildContext context) {
    return VisibleTagsProvider(
      child: Material(
        color: Colors.white,
        child: SafeArea(
          child: Row(
            children: [
              Expanded(child: BigLetter(selectedLetter: selectedLetter)),
              Expanded(
                child: SmallLetters(
                  onLetterSelected: (letter) {
                    setState(() => selectedLetter = letter);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BigLetter extends StatelessWidget {
  const BigLetter({Key? key, required this.selectedLetter}) : super(key: key);

  final String? selectedLetter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Letter', style: Theme.of(context).textTheme.headline3),
        Expanded(
          child: Center(
            child: NoHero(
              key: ValueKey(selectedLetter),
              tag: selectedLetter ?? 'None',
              child: Text(
                selectedLetter ?? 'None',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class VisibleTagsProvider extends StatefulWidget {
  const VisibleTagsProvider({super.key, required this.child});

  final Widget child;

  @override
  State<VisibleTagsProvider> createState() => _VisibleTagsProviderState();
}

class _VisibleTagsProviderState extends State<VisibleTagsProvider>
    with SingleTickerProviderStateMixin {
  late final animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 500),
  );

  @override
  void initState() {
    super.initState();
    animationController.addListener(() => setState(() {}));
  }

  var tweens = IList<Tween<Offset>>();

  var visibleTags = IList<Tag>();

  void addTagIfNotPresent(Tag tag) {
    print('addTagIfNotPresent $tag');
    if (!visibleTags.contains(tag)) {
      setState(() {
        visibleTags = visibleTags.add(tag);
      });
    } else {
      final initialTag = visibleTags.firstWhere((element) => element == tag);
      tweens = tweens
          .add(Tween<Offset>(begin: initialTag.position, end: tag.position));
      animationController.forward(from: 0);
    }
  }

  void removeTag(String key) {
    setState(() {
      visibleTags = visibleTags.removeWhere((tag) => tag.key == key);
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: VisibleTags(
            visibleTags: visibleTags,
            addTagIfNotPresent: addTagIfNotPresent,
            removeTag: removeTag,
            child: widget.child,
          ),
        ),
        for (final tween in tweens)
          Positioned(
            top: tween.evaluate(animationController).dy,
            left: tween.evaluate(animationController).dx,
            child: ColoredBox(
              color: Colors.redAccent,
              child: SizedBox.square(
                dimension: 50,
              ),
            ),
          ),
      ],
    );
  }
}

class VisibleTags extends InheritedWidget {
  VisibleTags({
    Key? key,
    required Widget child,
    required this.visibleTags,
    required this.addTagIfNotPresent,
    required this.removeTag,
  }) : super(key: key, child: child);

  final IList<Tag> visibleTags;
  final void Function(Tag tag) addTagIfNotPresent;
  final void Function(String key) removeTag;

  static VisibleTags of(BuildContext context) {
    final VisibleTags? result =
        context.dependOnInheritedWidgetOfExactType<VisibleTags>();
    assert(result != null, 'No VisibleTags found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(VisibleTags old) {
    return true;
  }
}

class SmallLetters extends StatelessWidget {
  SmallLetters({Key? key, required this.onLetterSelected}) : super(key: key);

  final void Function(String) onLetterSelected;

  final alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Letters', style: Theme.of(context).textTheme.headline3),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            children: [
              for (final letter in alphabet)
                GestureDetector(
                  onTap: () => onLetterSelected(letter),
                  child: Container(
                    color: Colors.blue,
                    child: Center(
                      child: NoHero(
                        tag: letter,
                        child: Text(
                          letter,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

// 1. Get the widget size and position
//
//      Widget      <-      Element        ->      RenderObject
//    ColoredBox    <-  ColoredBoxElement  ->  RenderColoredBox
//
// 2.
class NoHero extends StatefulWidget {
  const NoHero({super.key, required this.child, required this.tag});

  final Widget child;
  final String tag;

  @override
  State<NoHero> createState() => _NoHeroState();
}

class _NoHeroState extends State<NoHero> {
  late final bool visible;
  var isInitialized = false;
  late final VisibleTags visibleTags;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      visibleTags = VisibleTags.of(context);
      visible = visibleTags.visibleTags.fold<bool>(
        true,
        (previous, tag) => previous || tag.key == widget.tag,
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final renderObject = (context as Element).renderObject as RenderBox;
        final size = renderObject.size;
        final position = renderObject.localToGlobal(Offset.zero);

        visibleTags.addTagIfNotPresent(
          Tag(
            key: widget.tag,
            size: size,
            position: position,
          ),
        );
      });
      isInitialized = true;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      visibleTags.removeTag(widget.tag);
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: visible ? 1 : 0,
      child: widget.child,
    );
  }
}

class Tag extends Equatable {
  final String key;
  final Size size;
  final Offset position;

  Tag({required this.key, required this.size, required this.position});

  @override
  List<Object?> get props => [key];
}
