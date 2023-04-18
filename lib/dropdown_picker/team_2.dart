import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class DropdownPickerTeam2 extends StatefulWidget with TeamMixin {
  final teamName = 'Team2';

  @override
  State<DropdownPickerTeam2> createState() => _DropdownPickerTeam2State();
}

class _DropdownPickerTeam2State extends State<DropdownPickerTeam2> {
  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}
