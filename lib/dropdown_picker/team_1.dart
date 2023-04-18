import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class DropdownPickerTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<DropdownPickerTeam1> createState() => _DropdownPickerTeam1State();
}

class _DropdownPickerTeam1State extends State<DropdownPickerTeam1> {
  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}
