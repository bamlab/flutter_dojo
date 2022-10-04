import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class ScrollProgressTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<ScrollProgressTeam3> createState() => _ScrollProgressTeam3State();
}

class _ScrollProgressTeam3State extends State<ScrollProgressTeam3> {
  final controller = ScrollController();
  final imageHeight = 300.0;
  final maxImageCount = 10;
  int currentIndex = 0;

  double previousOffset = 0.0;
  double currentOffsetPercentage = 0.0;

  @override
  initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        if (!controller.hasClients) {
          return;
        }
        currentIndex = controller.offset ~/ imageHeight;

        currentOffsetPercentage += (controller.offset - previousOffset) /
            controller.position.maxScrollExtent;
        previousOffset = controller.offset;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Create an infinite list of random images
    return Material(
      color: Colors.black,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          notification.depth;
          return false;
        },
        child: SafeArea(
          child: Stack(
            children: [
              Scrollbar(
                controller: controller,
                child: ListView.separated(
                  controller: controller,
                  itemCount: 20,
                  separatorBuilder: (context, index) => Divider(
                    height: 5,
                    color: Colors.black,
                  ),
                  itemBuilder: (context, index) {
                    return _RandomImage(index: index, height: imageHeight);
                  },
                ),
              ),
              Align(
                alignment: Alignment(1, currentOffsetPercentage * 2 - 1),
                child: SizedBox(
                  height: 100,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: _ScrollBarPopup(
                      index: maxImageCount - currentIndex,
                      progress: currentIndex / maxImageCount,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RandomImage extends StatelessWidget {
  const _RandomImage({Key? key, required this.index, required this.height})
      : super(key: key);

  final int index;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: height / 200,
        child: Image.network(
          'https://picsum.photos/seed/${index + 3}/${height.toInt()}/200',
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

class _ScrollBarPopup extends StatelessWidget {
  const _ScrollBarPopup({
    Key? key,
    required this.index,
    required this.progress,
  }) : super(key: key);

  final int index;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[800]!.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 3,
              backgroundColor: Colors.grey,
            ),
          ),
          SizedBox(width: 10),
          Text(
            '$index',
            style: TextStyle(
                color: Colors.grey[200],
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
