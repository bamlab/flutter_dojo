import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OutOfScreenTeam1 extends TeamWidget {
  const OutOfScreenTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Team1');

  @override
  Widget build(BuildContext context) {
    return AvatarLinkProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Material(
          child: Scaffold(
            // Try DojoOutOfScreen.outOfScreenCard to get the card design
            backgroundColor: Colors.grey[300],
            body: SafeArea(
              child: BasicScreen(),
            ),
          ),
        ),
      ),
    );
  }
}

class BasicScreen extends StatefulWidget {
  const BasicScreen({Key? key}) : super(key: key);

  @override
  State<BasicScreen> createState() => _BasicScreenState();
}

class _BasicScreenState extends State<BasicScreen>
    with SingleTickerProviderStateMixin {
  late final animation = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 335),
  );

  late final curvedAnimation = CurvedAnimation(
    parent: animation,
    curve: Curves.linearToEaseOut,
    reverseCurve: Curves.easeInToLinear,
  );

  final yTween = Tween<double>(begin: 0, end: -400);

  Future<void> onAvatarTap(BuildContext context) async {
    animation.forward();
    Navigator.of(context).push(
      CupertinoModalPopupRoute(
        barrierColor: Colors.transparent,
        builder: (context) => OutOfScreenCard(onPop: () => animation.reverse()),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    animation.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, yTween.evaluate(curvedAnimation)),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Watching',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  ),
                  GestureDetector(
                    onTap: () => onAvatarTap(context),
                    child: SizedBox.square(
                      dimension: 50,
                      child: _Avatar(),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                    ),
                    child: Text('Randomly change the avatar'),
                    onPressed: () {
                      _AvatarLinkProvider.of(context).randomlyChangeLink();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OutOfScreenCard extends StatelessWidget {
  const OutOfScreenCard({Key? key, required this.onPop}) : super(key: key);

  final void Function() onPop;

  @override
  Widget build(BuildContext context) {
    final avatarSize = 100.0;
    return WillPopScope(
      onWillPop: () {
        onPop();
        return Future.value(true);
      },
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Avatar
              Positioned(
                top: -avatarSize / 2,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox.square(
                    dimension: avatarSize,
                    child: _Avatar(),
                  ),
                ),
              ),

              // Content
              Positioned(
                child: Padding(
                  padding: EdgeInsets.only(top: avatarSize / 2),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 8),
                      Text(
                        'John Doe',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                      SizedBox(height: 8),
                      _RoundedSeparator(),
                      SizedBox(height: 8),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _ActionRow(icon: Icons.settings, label: 'Account'),
                            SizedBox(height: 8),
                            _ActionRow(icon: Icons.help, label: 'Help'),
                            SizedBox(height: 8),
                            _ActionRow(icon: Icons.logout, label: 'Logout'),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(height: avatarSize / 2),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({Key? key, required this.icon, required this.label})
      : super(key: key);

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon),
        SizedBox(width: 8),
        Text(label, style: TextStyle(fontSize: 30)),
      ],
    );
  }
}

class _RoundedSeparator extends StatelessWidget {
  const _RoundedSeparator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      child: ClipRRect(
        child: Image.network(
          _AvatarLinkProvider.of(context).link,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _AvatarLinkProvider extends InheritedWidget {
  const _AvatarLinkProvider({
    Key? key,
    required Widget child,
    required this.link,
    required this.randomlyChangeLink,
  }) : super(key: key, child: child);

  final String link;
  final VoidCallback randomlyChangeLink;

  static _AvatarLinkProvider of(BuildContext context) {
    final _AvatarLinkProvider? result =
        context.dependOnInheritedWidgetOfExactType<_AvatarLinkProvider>();
    assert(result != null, 'No _AvatarProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_AvatarLinkProvider old) {
    return link != old.link;
  }
}

class AvatarLinkProviderScope extends StatefulWidget {
  const AvatarLinkProviderScope({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _AvatarLinkProviderScopeState createState() =>
      _AvatarLinkProviderScopeState();
}

class _AvatarLinkProviderScopeState extends State<AvatarLinkProviderScope> {
  var _link =
      'https://avatars.dicebear.com/api/adventurer/${Random().nextInt(1000)}.png';

  @override
  Widget build(BuildContext context) {
    return _AvatarLinkProvider(
      link: _link,
      child: widget.child,
      randomlyChangeLink: () {
        setState(() {
          _link =
              'https://avatars.dicebear.com/api/adventurer/${Random().nextInt(1000)}.png';
        });
      },
    );
  }
}
