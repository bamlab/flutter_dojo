import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

/// Design: https://twitter.com/theShaneLevine/status/1632583470512844800?s=20

final _teams = <TeamMixin>[
  ElasticScrollTeam1(),
  ElasticScrollTeam2(),
  ElasticScrollTeam3(),
];

class DojoElasticScroll extends DojoWidget {
  DojoElasticScroll({
    Key? key,
  }) : super(key: key, dojoName: 'ElasticScroll', teams: _teams);
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                'Messages',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            ...[
              for (var i = 0; i < 20; i++)
                () {
                  final name = faker.person.name();

                  return Message(
                    name: name,
                    avatarUrl:
                        'https://avatars.dicebear.com/api/adventurer/$name.png',
                    message: 'Hello there!',
                  );
                }()
            ]
          ],
        ),
      ),
    );
  }
}

class Message extends StatelessWidget {
  final String avatarUrl;
  final String message;
  final String name;

  Message({
    super.key,
    required this.avatarUrl,
    required this.name,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(avatarUrl),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                message,
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
