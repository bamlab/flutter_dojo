import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class BankAnimationTeam3 extends TeamWidget {
  const BankAnimationTeam3({
    Key? key,
  }) : super(key: key, teamName: 'Guillaume & Louis');

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _BottomBank(),
    );
  }
}

class _BottomBank extends StatefulWidget {
  const _BottomBank({Key? key}) : super(key: key);

  @override
  State<_BottomBank> createState() => _BottomBankState();
}

class _BottomBankState extends State<_BottomBank> {
  String _currentValue = '0';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        Text(
          _currentValue,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        MaterialButton(
            color: Colors.grey[200],
            child: const Text('Reset Amount'),
            elevation: 0,
            onPressed: () {
              setState(() {
                _currentValue = '0';
              });
            }),
        Expanded(child: NumKeyboard(onNumSelected: (String value) {
          setState(() {
            _currentValue += value;
          });
        }))
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
    required this.number,
    required this.onTap,
  }) : super(key: key);

  final String number;
  final void Function(String value) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(number),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle, border: Border.all(color: Colors.black12)),
        child: Center(
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}

class NumKeyboard extends StatelessWidget {
  final void Function(String value) onNumSelected;
  const NumKeyboard({Key? key, required this.onNumSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      padding: const EdgeInsets.all(50),
      crossAxisSpacing: 50,
      mainAxisSpacing: 20,
      children: List.generate(12, (index) {
        switch (index) {
          case 10:
            return _Button(number: '.', onTap: onNumSelected);
          default:
            return _Button(
                number: (index + 1).toString(), onTap: onNumSelected);
        }
      }),
    );
  }
}
