import 'package:flutter/material.dart';

abstract class TeamWidget extends StatelessWidget {
  final String teamName;

  const TeamWidget({Key? key, required this.teamName}) : super(key: key);
}

abstract class DojoWidget extends StatelessWidget {
  final String dojoName;

  const DojoWidget({Key? key, required this.dojoName}) : super(key: key);
}
