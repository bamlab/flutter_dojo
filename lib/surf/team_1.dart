import 'dart:math';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:bam_dojo/surf/surf.dart';
import 'package:flutter/material.dart';

class SurfTeam1 extends TeamWidget {
  const SurfTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Louis & Lucas');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SurfInfos(),
            SizedBox(height: 20),
            AvatarsRow(),
            SizedBox(height: 20),
            SurfButton(),
          ],
        ),
      ),
    );
  }
}

class SurfInfos extends StatelessWidget {
  const SurfInfos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Great spot for beginners',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          'Come random text blahblahCome random text blahblahCome random text blahblahCome random text blahblahCome random text blahblahCome random text blahblahCome random text blahblahCome random text blahblahCome random text blahblah',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}

class AvatarsRow extends StatelessWidget {
  const AvatarsRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double avatarSize = 50;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('People nearby'),
        const SizedBox(height: 10),
        SizedBox(
          height: avatarSize,
          child: Stack(
            children: [
              for (int i = 0; i < min(SurfData().peopleUrls.length, 5); i++)
                () {
                  double spacing = i == 0 ? 0 : avatarSize / 1.5;
                  return Positioned(
                    left: i * spacing,
                    child: SurfAvatar(
                      imageURL: SurfData().peopleUrls[i],
                      size: avatarSize,
                    ),
                  );
                }(),
              if (SurfData().peopleUrls.length > 5)
                Positioned(
                  left: 5 * avatarSize / 1.5,
                  child: SurfAvatarMore(
                    remainingCount: SurfData().peopleUrls.length - 5,
                    size: avatarSize,
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}

class SurfAvatarMore extends StatelessWidget {
  const SurfAvatarMore({
    Key? key,
    required this.size,
    required this.remainingCount,
  }) : super(key: key);
  final double size;
  final int remainingCount;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: SurfData().primary,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white),
      ),
      child: ClipRRect(
        child: Center(child: Text('+$remainingCount')),
        borderRadius: BorderRadius.circular(200),
      ),
    );
  }
}

class SurfAvatar extends StatelessWidget {
  const SurfAvatar({
    Key? key,
    required this.imageURL,
    required this.size,
  }) : super(key: key);

  final String imageURL;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white),
      ),
      child: ClipRRect(
        child: Image.network(imageURL),
        borderRadius: BorderRadius.circular(200),
      ),
    );
  }
}

class SurfButton extends StatelessWidget {
  const SurfButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: SurfData().secondary,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.white),
              children: [
                const TextSpan(text: 'Check in '),
                TextSpan(
                  text: '+10 points',
                  style: TextStyle(
                    color: SurfData().primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
