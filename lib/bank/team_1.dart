import 'package:bam_dojo/bank/bank.dart';
import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BankTeam1 extends TeamWidget {
  const BankTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Matthieu Lucas');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            _AnyIcon(
              icon: Icons.arrow_back,
            ),
            SizedBox(width: 16),
            Text(
              'Back',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: const [
          _AnyIcon(
            icon: Icons.notifications_outlined,
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:  [
            Center(child: Text('Send money', style: TextStyle(fontSize: 24))),
            SizedBox(height: 16),
            Text('Send to', style: TextStyle(fontSize: 12, color: Colors.grey)),
            SizedBox(height: 16),
            _PeopleCard(),
            SizedBox(height: 24),
            Text('MASSAGE (OPTIONAL)', style: TextStyle(fontSize: 12, color: Colors.grey)),
            SizedBox(height: 8),
            CupertinoTextField(
              placeholder: 'I already sent bro!',
              placeholderStyle: TextStyle(color: Colors.black),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blueGrey.withOpacity(0.1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnyIcon extends StatelessWidget {
  const _AnyIcon({Key? key, required this.icon}) : super(key: key);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kMinInteractiveDimension,
      height: kMinInteractiveDimension,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey,
          width: 0.5,
        ),
      ),
      alignment: Alignment.center,
      child: Icon(
        icon,
        color: Colors.black,
      ),
    );
  }
}

class _PeopleCard extends StatelessWidget {
  const _PeopleCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color:  Colors.black.withOpacity(0.06),
            offset: const Offset(0, 10),
            blurRadius: 18,
            spreadRadius: 10
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(BankData().userUrl),
            radius: 32,
          ),
          const SizedBox(width: 16),
          Column(
            children: const [
              Text('Matthieu Lucas'),
              SizedBox(height: 4),
              Text(
                '+33 6 12 34 56 78',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          Expanded(child: Container()),
          const RotatedBox(
            child: Icon(
              Icons.chevron_right,
              size: 40,
            ),
            quarterTurns: 1,
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
