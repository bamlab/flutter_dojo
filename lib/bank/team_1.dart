import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class BankTeam1 extends TeamWidget {
  const BankTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Matthieu Lucas');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(teamName)),
    );
  }
}
