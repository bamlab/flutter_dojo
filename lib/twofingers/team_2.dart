import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TwoFingersTeam2 extends TeamWidget {
  const TwoFingersTeam2({
    Key? key,
  }) : super(key: key, teamName: 'Louis & Lucas');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SwipeDemo()),
    );
  }
}

class SwipeDemo extends StatefulWidget {
  @override
  SwipeDemoState createState() => SwipeDemoState();
}

class SwipeDemoState extends State<SwipeDemo> {
  Offset offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TwoFingerPointerWidget(
        child: Container(
          alignment: Alignment.center,
          color: Colors.white,
          child: Transform.translate(
            offset: offset,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}

class TwoFingerPointerWidget extends StatefulWidget {
  final Widget child;

  TwoFingerPointerWidget({required this.child});

  @override
  State<TwoFingerPointerWidget> createState() => _TwoFingerPointerWidgetState();
}

class _TwoFingerPointerWidgetState extends State<TwoFingerPointerWidget> {
  Offset? _startDragOffset;
  Offset? _dragOffset;

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        VerticalMultiDragGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<
                VerticalMultiDragGestureRecognizer>(
          () => VerticalMultiDragGestureRecognizer(),
          (instance) {
            instance.onStart = (details) {
              setState(() {
                _startDragOffset = details;
                _dragOffset = details;
              });
            };
          },
        ),
        VerticalDragGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer>(
          () => VerticalDragGestureRecognizer(),
          (instance) {
            instance.onUpdate = (details) {
              if (_startDragOffset == null) {
                return;
              }

              setState(() {
                _dragOffset = details.globalPosition;
              });

              print('onUpdate, _dragOffset: $_dragOffset, _startDragOffset: $_startDragOffset');
            };
            instance.onEnd = (details) {
              setState(() {
                _startDragOffset = null;
                _dragOffset = null;
              });
            };
          },
        ),
      },
      child: widget.child,
    );
  }
}
