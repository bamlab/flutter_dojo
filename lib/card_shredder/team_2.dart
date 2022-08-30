import 'dart:typed_data';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;

class CardShredderTeam2 extends TeamWidget {
  const CardShredderTeam2({
    Key? key,
  }) : super(key: key, teamName: 'Team2');

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: _CardsHandler(),
    );
  }
}

class _CardsHandler extends StatefulWidget {
  const _CardsHandler({Key? key}) : super(key: key);

  @override
  State<_CardsHandler> createState() => _CardsHandlerState();
}

class _CardsHandlerState extends State<_CardsHandler> {
  GlobalKey globalKey = GlobalKey();

  img.Image? image;
  List<img.Image>? images;
  var showCutImages = false;

  Future<void> _capturePng() async {
    final pixelRatio = 2.0;
    final boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final uiImage = await boundary.toImage(pixelRatio: pixelRatio);

    final byteData = await uiImage.toByteData(format: ui.ImageByteFormat.png);
    
    final outOfSizeWidgetImage =
        img.decodeImage(byteData!.buffer.asUint8List())!;
    final widgetImage = img.copyResize(
      outOfSizeWidgetImage,
      width: outOfSizeWidgetImage.width ~/ pixelRatio,
      height: outOfSizeWidgetImage.height ~/ pixelRatio,
    );

    setState(() => image = widgetImage);
    print('End got the original image');

    _cutImage();
  }

  Future<void> _cutImage() async {
    final shredCount = 5;

    final image = this.image;
    if (image == null) return;
    final xLength = (image.width / shredCount).round();
    final pieceList = List.generate(
      shredCount,
      (x) => img.copyCrop(image, x * xLength, 0, xLength, image.height),
    );
    setState(() => images = pieceList);
    print('End cut the image in pieces');
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1)).then((value) => _capturePng());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() => showCutImages = !showCutImages);
        },
        child: Icon(Icons.cut_outlined),
      ),
      body: Center(
        child: RepaintBoundary(
          key: globalKey,
          child: () {
            final images = this.images;
            if (showCutImages && images != null) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final image in images) ...[
                    getImageWidgetOf(image),
                    SizedBox(width: 10),
                  ]
                ],
              );
            }

            return _BasicCard();
          }(),
        ),
      ),
    );
  }

  Image getImageWidgetOf(img.Image image) {
    return Image.memory(Uint8List.fromList(img.encodePng(image)));
  }
}

class _BasicCard extends StatelessWidget {
  const _BasicCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: Colors.blue,
        height: 100,
        width: 100,
        child: Center(
          child: Text('Hello\nWorld'),
        ),
      ),
    );
  }
}
