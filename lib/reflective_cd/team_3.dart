import 'package:bam_dojo/helpers/team_class.dart';
import 'package:bam_dojo/reflective_cd/reflective_cd.dart';
import 'package:flutter/material.dart';

class ReflectiveCDTeam3 extends StatefulWidget with TeamMixin {
  final teamName = 'Team3';

  @override
  State<ReflectiveCDTeam3> createState() => _ReflectiveCDTeam3State();
}

class _ReflectiveCDTeam3State extends State<ReflectiveCDTeam3> {
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
