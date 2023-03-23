import 'package:bam_dojo/reflective_cd/team_3.dart';
import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';

/// Design: https://twitter.com/theShaneLevine/status/1632583470512844800?s=20

final _teams = <TeamMixin>[
  ReflectiveCDTeam1(),
  ReflectiveCDTeam2(),
  ReflectiveCDTeam3(),
];

class DojoReflectiveCD extends DojoWidget {
  DojoReflectiveCD({
    Key? key,
  }) : super(key: key, dojoName: 'ReflectiveCD', teams: _teams);
}

class ReflectiveCDBase extends StatelessWidget {
  const ReflectiveCDBase({super.key, required this.reflectiveCD});

  final Widget reflectiveCD;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 127, 149, 177),
                Colors.black,
              ],
            ),
          ),
          child: Container(),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {},
            ),
          ),
          bottomNavigationBar: _FakeNavigationBar(),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SearchBar(),
                SizedBox(height: 16),
                reflectiveCD,
                SizedBox(height: 16),
                _PlaylistInfos(),
                SizedBox(height: 16),
                _SongList(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PlaylistInfos extends StatelessWidget {
  const _PlaylistInfos();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'My super playlist',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: ' - 30 songs',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Text(
            '2h 29m',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.favorite_outline, color: Colors.white),
              SizedBox(width: 16),
              Icon(Icons.download_for_offline_outlined, color: Colors.white),
              SizedBox(width: 16),
              Icon(Icons.more_horiz, color: Colors.white),
            ],
          )
        ],
      ),
    );
  }
}

class _SongList extends StatelessWidget {
  const _SongList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: List.generate(
                30, (index) => _SongTile(index.toString(), index == 1))
            .expand((element) => [element, SizedBox(height: 16)])
            .toList(),
      ),
    );
  }
}

class _SongTile extends StatelessWidget {
  const _SongTile(this.id, [this.isPlaying = false]);

  final String id;
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(
          'https://picsum.photos/200/${id}00',
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (isPlaying) ...[
                    Icon(
                      Icons.play_arrow,
                      color: Color.fromARGB(255, 42, 245, 49),
                      size: 16,
                    ),
                    SizedBox(width: 4),
                  ],
                  Text(
                    'Song title',
                    style: TextStyle(
                      color: isPlaying
                          ? Color.fromARGB(255, 42, 245, 49)
                          : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                'Artist name',
                style: TextStyle(color: Colors.white.withOpacity(0.5)),
              ),
            ],
          ),
        ),
        Spacer(),
        Icon(Icons.more_vert, color: Colors.white),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.white),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Find in playlist',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(width: 8),
          Icon(Icons.sort, color: Colors.white),
        ],
      ),
    );
  }
}

class _FakeNavigationBar extends StatelessWidget {
  const _FakeNavigationBar();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 32,
            right: 32,
            top: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.home, color: Colors.white),
                  SizedBox(height: 4),
                  Text('Home', style: TextStyle(color: Colors.white)),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.search_outlined,
                      color: Colors.white.withOpacity(0.7)),
                  SizedBox(height: 4),
                  Text('Search',
                      style: TextStyle(color: Colors.white.withOpacity(0.7))),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.my_library_music_outlined,
                      color: Colors.white.withOpacity(0.7)),
                  SizedBox(height: 4),
                  Text('Library',
                      style: TextStyle(color: Colors.white.withOpacity(0.7))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
