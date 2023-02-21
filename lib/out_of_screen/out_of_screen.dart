import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

// Design: https://twitter.com/philipcdavis/status/1550133881168269312

final _teams = <TeamMixin>[
  const OutOfScreenTeam1(),
  const OutOfScreenTeam2(),
  const OutOfScreenTeam3(),
];

class DojoOutOfScreen extends DojoWidget {
  DojoOutOfScreen({
    Key? key,
  }) : super(key: key, dojoName: 'OutOfScreen', teams: _teams);

  static Widget basicScreen() => BasicScreen();

  static Widget outOfScreenCard() => OutOfScreenCard();
}

class BasicScreen extends StatelessWidget {
  const BasicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoModalPopupRoute(
                      builder: (context) => const OutOfScreenCard(),
                    ),
                  );
                },
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
    );
  }
}

class OutOfScreenCard extends StatelessWidget {
  const OutOfScreenCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avatarSize = 100.0;
    return Material(
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
