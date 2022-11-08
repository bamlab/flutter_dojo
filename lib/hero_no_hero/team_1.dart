import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class HeroNoHeroTeam1 extends StatefulWidget with TeamMixin {
  const HeroNoHeroTeam1({
    Key? key,
  }) : super(key: key);

  @override
  String get teamName => 'Team1';

  @override
  State<HeroNoHeroTeam1> createState() => _HeroNoHeroTeam1State();
}

class _HeroNoHeroTeam1State extends State<HeroNoHeroTeam1> {
  String? selectedLetter;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(child: BigLetter(selectedLetter: selectedLetter)),
            Expanded(
              child: SmallLetters(
                onLetterSelected: (letter) {
                  setState(() => selectedLetter = letter);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BigLetter extends StatelessWidget {
  const BigLetter({Key? key, required this.selectedLetter}) : super(key: key);

  final String? selectedLetter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Letter', style: Theme.of(context).textTheme.headline3),
        Expanded(
          child: Center(
            child: Text(
              selectedLetter ?? 'None',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ),
      ],
    );
  }
}

class SmallLetters extends StatelessWidget {
  SmallLetters({Key? key, required this.onLetterSelected}) : super(key: key);

  final void Function(String) onLetterSelected;

  final alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Letters', style: Theme.of(context).textTheme.headline3),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            children: [
              for (final letter in alphabet)
                GestureDetector(
                  onTap: () => onLetterSelected(letter),
                  child: Container(
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        letter,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
