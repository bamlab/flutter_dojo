import 'package:bam_dojo/airtags/airtags.dart';
import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class Airtag {
  Airtag({
    required this.name,
    required this.carText,
    required this.walkText,
    required this.batteryText,
    required this.feetCount,
    required this.image,
  });

  final String name;
  final int carText;
  final int walkText;
  final int batteryText;
  final double feetCount;
  final Image image;
}

final airTags = [
  Airtag(
    name: 'Jake\'s Scooter',
    carText: 8,
    walkText: 13,
    batteryText: 41,
    feetCount: 832.9,
    image: Image.network(AirTagsData().scooterUrl),
  ),
  Airtag(
    name: 'My Airpods Max',
    carText: 0,
    walkText: 0,
    batteryText: 100,
    feetCount: 132.7,
    image: Image.network(AirTagsData().airpodMaxUrl),
  ),
  Airtag(
    name: 'My Airpods',
    carText: 0,
    walkText: 0,
    batteryText: 100,
    feetCount: 132.7,
    image: Image.network(AirTagsData().airpodMaxUrl),
  ),
  Airtag(
    name: 'My Airpods',
    carText: 0,
    walkText: 0,
    batteryText: 100,
    feetCount: 132.7,
    image: Image.network(AirTagsData().airpodMaxUrl),
  ),
  Airtag(
    name: 'My Airpods',
    carText: 0,
    walkText: 0,
    batteryText: 100,
    feetCount: 132.7,
    image: Image.network(AirTagsData().airpodMaxUrl),
  ),
  Airtag(
    name: 'My Airpods',
    carText: 0,
    walkText: 0,
    batteryText: 100,
    feetCount: 132.7,
    image: Image.network(AirTagsData().airpodMaxUrl),
  ),
  Airtag(
    name: 'My Airpods',
    carText: 0,
    walkText: 0,
    batteryText: 100,
    feetCount: 132.7,
    image: Image.network(AirTagsData().airpodMaxUrl),
  ),
  Airtag(
    name: 'My Airpods',
    carText: 0,
    walkText: 0,
    batteryText: 100,
    feetCount: 132.7,
    image: Image.network(AirTagsData().airpodMaxUrl),
  ),
  Airtag(
    name: 'My Airpods',
    carText: 0,
    walkText: 0,
    batteryText: 100,
    feetCount: 132.7,
    image: Image.network(AirTagsData().airpodMaxUrl),
  ),
  Airtag(
    name: 'My Airpods',
    carText: 0,
    walkText: 0,
    batteryText: 100,
    feetCount: 132.7,
    image: Image.network(AirTagsData().airpodMaxUrl),
  ),
];

class AirTagsTeam1 extends TeamWidget {
  const AirTagsTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Louis & Lucas');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: airTags.length,
        itemBuilder: (context, index) => AirTagCard(
          airTag: airTags[index],
        ),
      ),
    );
  }
}

class AirTagCard extends StatelessWidget {
  const AirTagCard({Key? key, required this.airTag}) : super(key: key);
  final Airtag airTag;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          AirTagBody(
            title: airTag.name,
            carText: airTag.carText,
            walkText: airTag.walkText,
            batteryText: airTag.batteryText,
            feetCount: airTag.feetCount,
          ),
          Align(
            alignment: const Alignment(1.2, 1),
            child: SizedBox(
              width: 80,
              height: 80,
              child: airTag.image,
            ),
          )
        ],
      ),
    );
  }
}

class AirTagBody extends StatelessWidget {
  const AirTagBody({
    Key? key,
    required this.title,
    required this.carText,
    required this.walkText,
    required this.batteryText,
    required this.feetCount,
  }) : super(key: key);
  final String title;
  final int carText;
  final int walkText;
  final int batteryText;
  final double feetCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(height: 5),
          AirtagInfo(
            carText: carText,
            walkText: walkText,
            batteryText: batteryText,
          ),
          const SizedBox(height: 10),
          AirTagsButtons(feetCount: feetCount),
        ],
      ),
    );
  }
}

class AirTagsButtons extends StatelessWidget {
  const AirTagsButtons({
    Key? key,
    required this.feetCount,
  }) : super(key: key);

  final double feetCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AirtagButton(icon: AirTagsData().playIcon, text: 'Play sound'),
        const SizedBox(width: 10),
        AirtagButton(
          icon: AirTagsData().navifationIcon,
          text: '${feetCount.toStringAsFixed(1)} ft',
        ),
      ],
    );
  }
}

class AirtagInfo extends StatelessWidget {
  const AirtagInfo({
    Key? key,
    required this.carText,
    required this.walkText,
    required this.batteryText,
  }) : super(key: key);

  final int carText;
  final int walkText;
  final int batteryText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(AirTagsData().carIcon),
        const SizedBox(width: 1),
        Text('$carText min'),
        const SizedBox(width: 20),
        Icon(AirTagsData().walkIcon),
        const SizedBox(width: 1),
        Text('$walkText min'),
        const SizedBox(width: 20),
        Icon(AirTagsData().batteryIcon),
        const SizedBox(width: 1),
        Text('$batteryText%'),
      ],
    );
  }
}

class AirtagButton extends StatelessWidget {
  const AirtagButton({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey[200],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }
}
