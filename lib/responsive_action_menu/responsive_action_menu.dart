import 'package:flutter/material.dart';

import '../helpers/team_class.dart';
import 'team_1.dart';
import 'team_2.dart';
import 'team_3.dart';

// Design: https://twitter.com/philipcdavis/status/1550133881168269312


final _teams = <TeamMixin>[
  const ResponsiveActionMenuTeam1(),
  const ResponsiveActionMenuTeam2(),
  const ResponsiveActionMenuTeam3(),
];

class DojoResponsiveActionMenu extends DojoWidget {
  DojoResponsiveActionMenu({
    Key? key,
  }) : super(key: key, dojoName: 'ResponsiveActionMenu', teams: _teams);

  static List<User> users = [
    User(fullName: 'John Doe'),
    User(fullName: 'Jane Doe'),
    User(fullName: 'John Smith'),
    User(fullName: 'Jane Smith'),
  ];
}

class User {
  final String fullName;

  User({required this.fullName});
}


/// Returns a list of widgets separated by the given [separator].
List<Widget> buildSeparated(Iterable<Widget> children, {required Widget separator}) {
  final result = <Widget>[];
  for (final child in children) {
    result.add(child);
    result.add(separator);
  }
  result.removeLast();
  return result;
}

class UserListTileBody extends StatelessWidget {
  const UserListTileBody({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    final avatarSize = 40.0;
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth*0.7,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Avatar
              ClipOval(
                child: Image.network(
                  'https://avatars.dicebear.com/api/adventurer-neutral/${user.fullName}.png',
                  height: avatarSize,
                  width: avatarSize,
                ),
              ),
              const SizedBox(width: 8),
              Text(user.fullName, style: Theme.of(context).textTheme.headline6),
            ],
          ),
        );
      }
    );
  }
}
