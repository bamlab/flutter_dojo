import 'package:bam_dojo/bank/bank.dart';
import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class BankTeam3 extends TeamWidget {
  const BankTeam3({
    Key? key,
  }) : super(key: key, teamName: 'Guillaume & Vincent');

  @override
  Widget build(BuildContext context) {
    final data = BankData();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 200,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 16),
            Container(
              width: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.grey[200]!, width: 2),
              ),
              child: const IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: null,
              ),
            ),
            const SizedBox(width: 16),
            const Text(
              'Back',
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        actions: [
          Container(
            width: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Colors.grey[200]!, width: 2),
            ),
            child: const IconButton(
              icon: Icon(
                Icons.add_alert_outlined,
                color: Colors.black,
              ),
              onPressed: null,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          children: [
            const _Title(),
            const SizedBox(
              height: 8,
            ),
            _Card(data: data),
            const SizedBox(
              height: 24,
            ),
            const _TextInput(),
            const SizedBox(
              height: 24,
            ),
            const _Amount(),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    Key? key,
    required this.data,
  }) : super(key: key);

  final BankData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "SEND TO",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(data.userUrl),
                  radius: 30,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Daniel De Rossi",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "+33 6 35 17 03 34",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    )
                  ],
                ),
                const Spacer(),
                const Icon(Icons.expand_more),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Send Money",
        style: TextStyle(
          color: Colors.black,
          fontSize: 28,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _TextInput extends StatelessWidget {
  const _TextInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'MESSAGE (OPTIONNAL)',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        TextField(
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.5),
            ),
            hintText: 'Message',
          ),
        ),
      ],
    );
  }
}

class _Amount extends StatelessWidget {
  const _Amount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'AMOUNT (USD)',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          '\$150.00',
          style: TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        Chip(
          label: const Text(
            'Reset amount',
            style: TextStyle(fontSize: 11),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          backgroundColor: Colors.grey[200],
        )
      ],
    );
  }
}
