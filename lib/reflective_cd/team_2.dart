import 'package:bam_dojo/helpers/team_class.dart';
import 'package:bam_dojo/reflective_cd/reflective_cd.dart';
import 'package:flutter/material.dart';

class ReflectiveCDTeam2 extends StatefulWidget with TeamMixin {
  final teamName = 'Team2';

  @override
  State<ReflectiveCDTeam2> createState() => _ReflectiveCDTeam2State();
}

class _ReflectiveCDTeam2State extends State<ReflectiveCDTeam2> {
  @override
  Widget build(BuildContext context) {
    return ReflectiveCDBase(
      reflectiveCD: _ReflectiveCD(),
    );
  }
}

class _ReflectiveCD extends StatelessWidget {
  const _ReflectiveCD();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Image.asset('assets/images/cd_case.jpg'),
    );
  }
}
