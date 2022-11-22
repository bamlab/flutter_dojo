import 'package:bam_dojo/helpers/team_class.dart';
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
    with TickerProviderStateMixin {
  var tagsAnimationProperties = IList<TagAnimationProperties>();

  /// Maps the tag name to every visible tags.
  ///
  /// There should never be more than 2 elements per list, since we wouldn't know
  /// how to interpolate if there were more.
  var visibleTags = IMap<String, IList<Tag>>();

  void add(Tag tag, {required void Function() onAnimationEnd}) async {
    final previousSimilarTags = visibleTags[tag.key] ?? IList<Tag>();

    // Update the visible tags.
    assert(previousSimilarTags.length < 2, 'Too many tags');
    visibleTags = visibleTags.update(
      tag.key,
      (tags) => tags.add(tag),
      ifAbsent: () => IList([tag]),
    );

    // If there was a previous tag, interpolate between the two.
    final previousSimilarTag = previousSimilarTags.firstOrNull;
    if (previousSimilarTag != null) {
      final animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500),
      );
      final positionAnimation = Tween<Offset>(
        begin: previousSimilarTag.position,
        end: tag.position,
      ).animate(animationController);
      final sizeAnimation = Tween<Size>(
        begin: previousSimilarTag.size,
        end: tag.size,
      ).animate(animationController);
      final tagAnimationProperties = TagAnimationProperties(
        position: positionAnimation,
        size: sizeAnimation,
        widget: tag.widget,
      );
      setState(
        () => tagsAnimationProperties = tagsAnimationProperties.add(
          tagAnimationProperties,
        ),
      );

      animationController.addListener(() => setState(() {}));
      await animationController.forward();

      animationController.dispose();
      setState(
        () => tagsAnimationProperties = tagsAnimationProperties.remove(
          tagAnimationProperties,
        ),
      );
    }

    onAnimationEnd();
  }

  void removeTag(Tag tag) {
    setState(() {
      visibleTags = visibleTags.update(
        tag.key,
        (tags) => tags.remove(tag),
        ifAbsent: () => IList(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: VisibleTags(
            visibleTags: visibleTags,
            add: add,
            removeTag: removeTag,
            child: widget.child,
          ),
        ),
        for (final tagAnimationProperties in tagsAnimationProperties)
          () {
            return Positioned(
              top: tagAnimationProperties.position.value.dy,
              left: tagAnimationProperties.position.value.dx,
              width: tagAnimationProperties.size.value.width,
              height: tagAnimationProperties.size.value.height,
              child: FittedBox(
                fit: BoxFit.contain,
                child: tagAnimationProperties.widget,
              ),
            );
          }()
      ],
    );
  }
}

class TagAnimationProperties {
  TagAnimationProperties({
    required this.position,
    required this.size,
    required this.widget,
  });

  final Animation<Offset> position;
  final Animation<Size> size;
  final Widget widget;
}

class VisibleTags extends InheritedWidget {
  VisibleTags({
    Key? key,
    required Widget child,
    required this.visibleTags,
    required this.add,
    required this.removeTag,
  }) : super(key: key, child: child);

  final IMap<String, IList<Tag>> visibleTags;
  final void Function(Tag tag, {required void Function() onAnimationEnd}) add;
  final void Function(Tag tag) removeTag;

  static VisibleTags of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<VisibleTags>();
    assert(result != null, 'No VisibleTags found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(VisibleTags old) => true;
}

class SmallLetters extends StatelessWidget {
  SmallLetters({Key? key, required this.onLetterSelected}) : super(key: key);

  final void Function(String letter) onLetterSelected;

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
  bool visible = false;
  var isInitialized = false;

  late final VisibleTags visibleTags;

  late final Tag tag;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      visibleTags = VisibleTags.of(context);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        final renderObject = (context as Element).renderObject as RenderBox;
        final size = renderObject.size;
        final position = renderObject.localToGlobal(Offset.zero);

        tag = Tag(
          key: widget.tag,
          size: size,
          position: position,
          widget: widget.child,
        );

        visibleTags.add(
          tag,
          onAnimationEnd: () => setState(() => visible = true),
        );
      });
      isInitialized = true;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      visibleTags.removeTag(tag);
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

class Tag {
  final String key;
  final Size size;
  final Offset position;
  final Widget widget;

  Tag({
    required this.key,
    required this.size,
    required this.position,
    required this.widget,
  });
}
