import 'package:bam_dojo/airtags/airtags.dart';
import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

final airtagsData = AirTagsData();

class AirTagsTeam3 extends TeamWidget {
  const AirTagsTeam3({
    Key? key,
  }) : super(key: key, teamName: 'Guillaumes');

  @override
  Widget build(BuildContext context) {
    final data = [
      {'name': 'Jake\'s Scooter', 'imageUrl': airtagsData.scooterUrl},
      {'name': 'AirPods Max', 'imageUrl': airtagsData.airpodMaxUrl}
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DeviceText(),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              reverse: true,
              children: data
                  .map(
                    (item) => AirTagItem(
                      title: item['name']!,
                      imageUrl: item['imageUrl']!,
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}

class DeviceText extends StatelessWidget {
  const DeviceText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        "Devices",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      ),
    );
  }
}

class AirTagItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  const AirTagItem({Key? key, required this.title, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const InfoRow(
                    carTime: 8,
                    walTime: 13,
                    batteryPercentage: 41,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Button(
                          icon: Icon(airtagsData.playIcon),
                          text: 'Play',
                        ),
                      ),
                      Expanded(
                        child: Button(
                          icon: Transform.rotate(
                            angle: 45.0,
                            child: Icon(
                              airtagsData.navifationIcon,
                            ),
                          ),
                          text: 'Navigate',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        ItemImage(imageUrl: imageUrl),
      ],
    );
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({
    Key? key,
    required this.carTime,
    required this.walTime,
    required this.batteryPercentage,
  }) : super(key: key);
  final int carTime;
  final int walTime;
  final int batteryPercentage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconText(
          icon: airtagsData.carIcon,
          text: "$carTime min",
        ),
        const SizedBox(
          width: 8,
        ),
        IconText(
          icon: airtagsData.walkIcon,
          text: "$walTime min",
        ),
        const SizedBox(
          width: 8,
        ),
        IconText(
          icon: airtagsData.batteryIcon,
          text: "$batteryPercentage%",
        )
      ],
    );
  }
}

class Button extends StatelessWidget {
  const Button({Key? key, required this.icon, required this.text})
      : super(key: key);
  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(
            width: 8,
          ),
          Text(text)
        ],
      ),
    );
  }
}

class IconText extends StatelessWidget {
  const IconText({Key? key, required this.icon, required this.text})
      : super(key: key);
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon),
        const SizedBox(
          width: 4,
        ),
        Text(text)
      ],
    );
  }
}

class ItemImage extends StatelessWidget {
  final String imageUrl;

  const ItemImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Image.network(
        imageUrl,
        width: 100.0,
      ),
      right: 40.0,
      bottom: -40.0,
    );
  }
}
