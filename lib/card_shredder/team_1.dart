import 'package:bam_dojo/card_shredder/team_1/fade_out_particle.dart';
import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class CardShredderTeam1 extends TeamWidget {
  const CardShredderTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Team1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _Card()),
    );
  }
}

class _Card extends StatefulWidget {
  const _Card({Key? key}) : super(key: key);

  @override
  State<_Card> createState() => _CardState();
}

class _CardState extends State<_Card> {
  bool fade = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FadeOutParticle(
          disappear: fade,
          child: SizedBox.square(
            dimension: 150,
            child: ColoredBox(color: Colors.redAccent),
          ),
        ),
        MaterialButton(
          onPressed: () {
            setState(
              () {
                fade = !fade;
              },
            );
          },
          child: Text('Disapear'),
        )
      ],
    );
  }
}
