import 'package:bam_dojo/helpers/team_class.dart';
import 'package:faker/faker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

const baseDividerHeight = 8;
final names = List.generate(20, (_) => faker.person.name());

class ElasticScrollTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<ElasticScrollTeam1> createState() => _ElasticScrollTeam1State();
}

class _ElasticScrollTeam1State extends State<ElasticScrollTeam1> {
  @override
  Widget build(BuildContext context) {
    return MainPage();
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final scrollController = ScrollController();
  var scrollUpOffset = 0.0;
  var maxScrollOffset = 0.0;
  var scrollDownOffset = 0.0;

  @override
  void initState() {
    scrollController.addListener(() {
      setState(() {
        scrollUpOffset =
            scrollController.offset < 0 ? scrollController.offset * (-0.3) : 0;
        maxScrollOffset = maxScrollOffset == 0.0
            ? scrollController.position.maxScrollExtent
            : maxScrollOffset;
        scrollDownOffset = scrollController.offset > maxScrollOffset
            ? (scrollController.offset - maxScrollOffset) * 0.3
            : 0;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          controller: scrollController,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Messages',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            ...[
              for (var i = 0; i < 20; i++)
                () {
                  return Transform.translate(
                    offset: Offset(0, -scrollDownOffset * (20 - i)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: baseDividerHeight + scrollUpOffset,
                        ),
                        Message(
                          name: names[i],
                          avatarUrl:
                              'https://avatars.dicebear.com/api/adventurer/${names[i]}.png',
                          message: 'Hello there!',
                        ),
                      ],
                    ),
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
      ],
    );
  }
}
