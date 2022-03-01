import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class AirTagsTeam2 extends TeamWidget {
  const AirTagsTeam2({
    Key? key,
  }) : super(key: key, teamName: 'Vincent & Valentin');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(clipBehavior: Clip.none, children: [
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Jake's Scooter"),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(children: [
                        iconItem(),
                        const SizedBox(
                          width: 10,
                        ),
                        iconItem(),
                        const SizedBox(
                          width: 10,
                        ),
                        iconItem()
                      ]),
                    ]),
              ),
            ),
            const Positioned(right: 30, top: -20, child: Scooter()),
          ]),
        ),
      ),
    );
  }

  Row iconItem() {
    return Row(
      children: const [Icon(Icons.car_repair), Text('8 min')],
    );
  }
}

class Scooter extends StatelessWidget {
  const Scooter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Image(
        width: 80,
        image: NetworkImage(
            'https://firebasestorage.googleapis.com/v0/b/orga-47ea2.appspot.com/o/assets%2FPikPng.com_scooty-png_384580.png?alt=media&token=71b0a1d7-9e6c-44f5-9d67-af10cccc6841'));
  }
}
