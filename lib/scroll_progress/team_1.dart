import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class ScrollProgressTeam1 extends StatelessWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  Widget build(BuildContext context) {
    // Create an infinite list of random images
    return Material(
      color: Colors.black,
      child: ListView.separated(
        itemCount: 1000,
        separatorBuilder: (context, index) => Divider(
          height: 5,
          color: Colors.black,
        ),
        itemBuilder: (context, index) {
          return _RandomImage(index: index);
        },
      ),
    );
  }
}

class _RandomImage extends StatelessWidget {
  const _RandomImage({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 300 / 200,
        child: Image.network(
          'https://picsum.photos/seed/${index + 1}/300/200',
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
