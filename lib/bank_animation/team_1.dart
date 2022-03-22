import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class BankAnimationTeam1 extends TeamWidget {
  const BankAnimationTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Guillaue & Lucas');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: const [
              _InputPrice(),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputPrice extends StatefulWidget {
  const _InputPrice({Key? key}) : super(key: key);

  @override
  State<_InputPrice> createState() => __InputPriceState();
}

class __InputPriceState extends State<_InputPrice> {
  double _value = 5;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showBottomSheet(
          enableDrag: true,
          context: context,
          builder: (context) => _Keyboard(
            value: _value,
            onValueChanged: (value) =>
                setState(() => _value = double.tryParse(value) ?? _value),
          ),
        );
      },
      child: Text(
        '$_value',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _Keyboard extends StatefulWidget {
  const _Keyboard({Key? key, required this.value, required this.onValueChanged})
      : super(key: key);

  final double value;
  final ValueChanged<String> onValueChanged;

  @override
  State<_Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<_Keyboard> {
  late double value = widget.value;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.grey[100]!,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 12,
              ),
              Center(
                child: Container(
                  height: 8,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[300]!,
                  ),
                ),
              ),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 3,
                children: [
                  ...List.generate(9, (index) => index + 1)
                      .map(
                        (i) => _InputNumber(
                          number: '$i',
                          onPressed: () {
                            final newValue = '$value$i';
                            widget.onValueChanged(newValue);
                            setState(() {
                              value = double.tryParse(newValue) ?? value;
                            });
                          },
                        ),
                      )
                      .toList(),
                ],
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputNumber extends StatelessWidget {
  const _InputNumber({
    Key? key,
    required this.number,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  final String number;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Center(
        child: Container(
          height: 54,
          width: 54,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: const TextStyle(fontSize: 28),
          ),
        ),
      ),
    );
  }
}
