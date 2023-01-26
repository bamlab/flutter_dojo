import 'dart:math';
import 'dart:ui';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class ScrollProgressTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<ScrollProgressTeam3> createState() => _ScrollProgressTeam3State();
}

class _ScrollProgressTeam3State extends State<ScrollProgressTeam3> {
  bool isBlur = false;

  final imageHeight = 300.0;
  final maxImageCount = 10;

  final scrollBarKey = GlobalKey<RawScrollbarState>();

  var currentIndex = 0;
  var currentOffset = 0.0;
  var currentOffsetPercentage = 0.0;

  final scrollbarPopupKey = GlobalKey();

  bool _handleScrollMetricsNotification(
    ScrollMetricsNotification notification,
  ) {
    if (notification.metrics.axis == Axis.vertical) {
      final metrics = notification.metrics;
      setState(() {
        currentOffset = metrics.pixels;
        currentIndex = currentOffset ~/ imageHeight;
        currentOffsetPercentage = currentOffset / metrics.maxScrollExtent;

        if (currentIndex >= maxImageCount + 1) {
          isBlur = true;
        } else {
          isBlur = false;
        }
      });
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: SafeArea(
        child: BlurredWidget(
          isBlur: isBlur,
          scrollbarPopupKey: scrollbarPopupKey,
          child: Stack(
            children: [
              CustomScrollbar(
                key: scrollBarKey,
                child: NotificationListener<ScrollMetricsNotification>(
                  onNotification: _handleScrollMetricsNotification,
                  child: ListView.builder(
                    itemCount: 30,
                    itemBuilder: (context, index) {
                      return _RandomImage(index: index, height: imageHeight);
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment(1, currentOffsetPercentage * 2 - 1),
                child: SizedBox(
                  height: 100,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Opacity(
                        opacity: 1,
                        child: _ScrollBarPopup(
                          key: scrollbarPopupKey,
                          index: maxImageCount - currentIndex,
                          progress: currentOffset / (imageHeight * maxImageCount),
                        ),
                      ),
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
            child: CustomPaint(
              painter: _CircularProgressPainter(
                value: progress,
                strokeWidth: 6,
                backgroundColor: Colors.grey,
              ),
            ),
          ),
          SizedBox(width: 10),
          SizedBox(
            width: 25,
            child: Center(
              child: Text(
                (index < 0 ? 0 : index).toString(),
                style: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BlurredWidget extends StatefulWidget {
  const BlurredWidget({
    Key? key,
    required this.isBlur,
    required this.child,
    required this.scrollbarPopupKey,
  }) : super(key: key);

  final bool isBlur;
  final Widget child;
  final GlobalKey scrollbarPopupKey;

  @override
  State<BlurredWidget> createState() => _BlurredWidgetState();
}

class _BlurredWidgetState extends State<BlurredWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant BlurredWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isBlur != widget.isBlur) {
      setState(() {
        if (widget.isBlur) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isBlur) {
      return widget.child;
    }
    // This is a fix for Flutter Web where setting the blur to 0 throws an
    // exception
    final safeBlur = max(1e-3, 30.0);

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    const scrollbarWidth = 3;

    final scrollbarPopupRenderBox = widget.scrollbarPopupKey.currentContext
        ?.findRenderObject() as RenderBox;
    final scrollbarPopupSize = scrollbarPopupRenderBox.size;
    final scrollbarPopupPosition =
        scrollbarPopupRenderBox.localToGlobal(Offset.zero);

    print(scrollbarPopupSize);
    print(scrollbarPopupPosition);

    return ClipRect(
      child: Stack(
        children: <Widget>[
          widget.child,
          Positioned(
            left: (1 - _controller.value) * (width - scrollbarWidth),
            right: scrollbarWidth * (1 - _controller.value),
            top: scrollbarPopupPosition.dy * (1 - _controller.value),
            bottom:
                (height - scrollbarPopupPosition.dy) * (1 - _controller.value),
            child: IgnorePointer(
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular((1 - _controller.value) * 200),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: safeBlur, sigmaY: safeBlur),
                  child: Container(
                    color: Colors.transparent,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: AnimatedRotation(
                              duration: const Duration(milliseconds: 300),
                              turns: _controller.value / 2,
                              child: Icon(
                                Icons.hourglass_top_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Limit Reached',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomScrollbar extends StatefulWidget {
  const CustomScrollbar({
    Key? key,
    required this.child,
    this.height = 100,
    this.thickness = 3,
    this.radius = const Radius.circular(10),
    this.thumbColor = Colors.white,
  }) : super(key: key);

  final Widget child;

  final double thickness;
  final double height;
  final Radius radius;
  final Color thumbColor;

  @override
  State<CustomScrollbar> createState() => _CustomScrollbarState();
}

class _CustomScrollbarState extends State<CustomScrollbar>
    with SingleTickerProviderStateMixin {
  late final opacityAnimationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 200),
  );
  late final opacityAnimation = opacityAnimationController.drive(
    Tween<double>(begin: 0, end: 1).chain(
      CurveTween(curve: Curves.easeInOut),
    ),
  );

  double topOffset = 0;

  @override
  void initState() {
    super.initState();
    opacityAnimationController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollMetricsNotification>(
      onNotification: _handleScrollMetricsNotification,
      child: NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: Stack(
          children: [
            widget.child,
            Positioned(
              right: 0,
              top: topOffset,
              child: Opacity(
                opacity: opacityAnimation.value,
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.thumbColor,
                    borderRadius: BorderRadius.all(widget.radius),
                  ),
                  width: widget.thickness,
                  height: widget.height,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _handleScrollMetricsNotification(
    ScrollMetricsNotification notification,
  ) {
    if (notification.metrics.axis == Axis.vertical) {
      setState(() {
        topOffset = notification.metrics.pixels /
            notification.metrics.maxScrollExtent *
            (notification.metrics.viewportDimension - widget.height);
      });
    }

    return false;
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollStartNotification) {
      opacityAnimationController.forward();
    } else if (notification is ScrollEndNotification) {
      opacityAnimationController.reverse();
    }

    return false;
  }
}

class _CircularProgressPainter extends CustomPainter {
  _CircularProgressPainter({
    required this.value,
    required this.strokeWidth,
    required this.backgroundColor,
  });

  final double value;
  final double strokeWidth;
  final Color backgroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - strokeWidth / 2;

    canvas.drawCircle(center, radius, paint);

    paint.color = Colors.white;

    final arcAngle = 2 * pi * value;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      arcAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_CircularProgressPainter oldDelegate) {
    return oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.value != value;
  }
}
