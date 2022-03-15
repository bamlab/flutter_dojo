import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class BankTeam2 extends TeamWidget {
  const BankTeam2({
    Key? key,
  }) : super(key: key, teamName: 'Valentin & Lucas');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(teamName)),
    );
  }
}
