import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class BankTeam3 extends TeamWidget {
  const BankTeam3({
    Key? key,
  }) : super(key: key, teamName: 'Valentin & Lucas');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(teamName)),
    );
  }
}
