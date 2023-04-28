import 'package:bam_dojo/helpers/team_class.dart';
import 'package:collection/collection.dart';
import 'package:faker/faker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

const baseDividerHeight = 8.0;
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        maxScrollOffset = scrollController.position.maxScrollExtent;
      });
    });
    scrollController.addListener(() {
      setState(() {
        scrollUpOffset =
            scrollController.offset < 0 ? scrollController.offset * (-0.3) : 0;
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
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          }),
          child: ListView(
            physics: const BouncingScrollPhysics(),
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
              ...names.mapIndexed((index, name) => Transform.translate(
                    offset: Offset(
                        0,
                        scrollUpOffset * index -
                            scrollDownOffset * (names.length - index)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: baseDividerHeight,
                        ),
                        Message(
                          name: name,
                          avatarUrl:
                              'https://avatars.dicebear.com/api/adventurer/$name.png',
                          message: 'Hello there!',
                        ),
                      ],
                    ),
                  ))
            ],
          ),
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
