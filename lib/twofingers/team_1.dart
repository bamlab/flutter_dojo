// ignore_for_file: use_key_in_widget_constructors

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TwoFingersTeam1 extends TeamWidget {
  const TwoFingersTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Guillaume & Vincent');

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _WidgetCool(),
    );
  }
}

class _WidgetCool extends StatefulWidget {
  const _WidgetCool({
    Key? key,
  }) : super(key: key);

  @override
  State<_WidgetCool> createState() => _WidgetCoolState();
}

class _WidgetCoolState extends State<_WidgetCool> {
  List<int> selectedIndex = [];

  @override
  Widget build(BuildContext context) {
    print(selectedIndex);
    return Center(
      child: TwoFingerPointerWidget(
        onUpdate: (details) {
          final index = details.globalPosition.dy ~/ 60 - 1;
          final direction = details.delta.dy.sign;
          print(details.delta);
          setState(() {
            if (!selectedIndex.contains(index) && direction > 0) {
              selectedIndex.add(index);
            }
            if (selectedIndex.contains(index) && direction < 0) {
              selectedIndex.remove(index);
            }
          });
        },
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: ((context, index) => SizedBox(
                height: 60,
                child: ListTile(
                  onTap: (() => setState(() {
                        setState(() {
                          if (!selectedIndex.contains(index)) {
                            selectedIndex.add(index);
                          } else if (selectedIndex.contains(index)) {
                            selectedIndex.remove(index);
                          }
                        });
                      })),
                  title: Text('Text $index'),
                  selected: selectedIndex.contains(index),
                  selectedTileColor: Colors.grey[200],
                  selectedColor: Colors.black,
                ),
              )),
          itemCount: 13,
        ),
      ),
    );
  }
}

class TwoFingerPointerWidget extends StatelessWidget {
  final Widget child;
  final OnUpdate onUpdate;

  const TwoFingerPointerWidget({required this.child, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        CustomVerticalMultiDragGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<
                CustomVerticalMultiDragGestureRecognizer>(
          () => CustomVerticalMultiDragGestureRecognizer(debugOwner: null),
          (CustomVerticalMultiDragGestureRecognizer instance) {
            instance.onStart = (Offset position) {
              return CustomDrag(events: instance.events, onUpdate: onUpdate);
            };
          },
        ),
      },
      child: child,
    );
  }
}

typedef OnUpdate = Function(DragUpdateDetails details);

class CustomDrag extends Drag {
  final List<PointerDownEvent> events;

  final OnUpdate onUpdate;

  CustomDrag({required this.events, required this.onUpdate});

  @override
  void update(DragUpdateDetails details) {
    super.update(details);
    final delta = details.delta;
    if (delta.dy.abs() > 0 && events.length == 2) {
      onUpdate.call(
        DragUpdateDetails(
          sourceTimeStamp: details.sourceTimeStamp,
          delta: Offset(0, delta.dy),
          primaryDelta: details.primaryDelta,
          globalPosition: details.globalPosition,
          localPosition: details.localPosition,
        ),
      );
    }
  }
}

class CustomVerticalMultiDragGestureRecognizer
    extends MultiDragGestureRecognizer {
  final List<PointerDownEvent> events = [];

  CustomVerticalMultiDragGestureRecognizer({required Object? debugOwner})
      : super(debugOwner: debugOwner);

  @override
  createNewPointerState(PointerDownEvent event) {
    events.add(event);
    return _CustomVerticalPointerState(
      event.position,
      onDisposeState: () {
        events.remove(event);
      },
    );
  }

  @override
  String get debugDescription => 'custom vertical multidrag';
}

typedef OnDisposeState = Function();

class _CustomVerticalPointerState extends MultiDragPointerState {
  final OnDisposeState onDisposeState;

  _CustomVerticalPointerState(
    Offset initialPosition, {
    required this.onDisposeState,
  }) : super(initialPosition, PointerDeviceKind.touch, null);

  @override
  void checkForResolutionAfterMove() {
    if (pendingDelta!.dy.abs() > kTouchSlop) {
      resolve(GestureDisposition.accepted);
    }
  }

  @override
  void accepted(GestureMultiDragStartCallback starter) {
    starter(initialPosition);
  }

  @override
  void dispose() {
    onDisposeState.call();
    super.dispose();
  }
}
