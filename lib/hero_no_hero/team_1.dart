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
  String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return VisibleTagsProvider(
      child: Material(
        color: Colors.white,
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: SelectedAvatar(avatarUrl: avatarUrl),
              ),
              Expanded(
                child: Avatars(
                  onAvatarSelected: (avatarUrl) {
                    setState(() => this.avatarUrl = avatarUrl);
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

class SelectedAvatar extends StatelessWidget {
  const SelectedAvatar({Key? key, required this.avatarUrl}) : super(key: key);

  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    final avatarUrl = this.avatarUrl;

    return Column(
      children: [
        Text('Selected', style: TextStyle(fontSize: 40)),
        Expanded(
          child: Center(
            child: avatarUrl == null
                ? SizedBox.shrink()
                : NoHero(
                    key: ValueKey(avatarUrl),
                    tag: avatarUrl,
                    child: Image.network(avatarUrl),
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
        begin: previousSimilarTag.getPosition(),
        end: tag.getPosition(),
      ).animate(animationController);
      final sizeAnimation = Tween<Size>(
        begin: previousSimilarTag.getSize(),
        end: tag.getSize(),
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

class Avatars extends StatelessWidget {
  Avatars({
    Key? key,
    required this.onAvatarSelected,
  }) : super(key: key);

  final void Function(String avatarUrl) onAvatarSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Avatars', style: TextStyle(fontSize: 40)),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final avatarUrl =
                  'https://avatars.dicebear.com/api/adventurer/$index.png';
              return GestureDetector(
                onTap: () => onAvatarSelected(avatarUrl),
                child: Center(
                  child: NoHero(
                    tag: avatarUrl,
                    child: Image.network(avatarUrl),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// How to get a widget size and position
//
// 1. The size and position is stored in the associated RenderObject.
//      Widget      <-      Element        ->      RenderObject
//    ColoredBox    <-  ColoredBoxElement  ->  RenderColoredBox
//
// 2. The `context` represents the Element
//
// Therefore we can use `context.findRenderObject()` to get the RenderObject and
// then get the size and position.
class NoHero extends StatefulWidget {
  const NoHero({super.key, required this.child, required this.tag});

  final Widget child;
  final String tag;

  @override
  State<NoHero> createState() => _NoHeroState();
}

class _NoHeroState extends State<NoHero> {
  var visible = false;
  var isInitialized = false;

  late final VisibleTags visibleTags;

  late final Tag tag;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      visibleTags = VisibleTags.of(context);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        tag = Tag(
          key: widget.tag,
          getSize: () {
            if (!mounted) {
              return Size.zero;
            }
            return (context.findRenderObject() as RenderBox).size;
          },
          getPosition: () {
            if (!mounted) {
              return Offset.zero;
            }
            return (context.findRenderObject() as RenderBox)
                .localToGlobal(Offset.zero);
          },
          widget: widget.child,
        );

        visibleTags.add(
          tag,
          onAnimationEnd: () {
            if (mounted) {
              setState(() => visible = true);
            }
          },
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
  final Size Function() getSize;
  final Offset Function() getPosition;
  final Widget widget;

  Tag({
    required this.key,
    required this.getSize,
    required this.getPosition,
    required this.widget,
  });
}
