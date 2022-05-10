import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class SignUpTeam1 extends TeamWidget {
  const SignUpTeam1({
    Key? key,
  }) : super(key: key, teamName: 'Guillaumes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade400,
      body: const _ShowBottom(),
    );
  }
}

class _ShowBottom extends StatefulWidget {
  const _ShowBottom({Key? key}) : super(key: key);

  @override
  State<_ShowBottom> createState() => _ShowBottomState();
}

class _ShowBottomState extends State<_ShowBottom> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(42),
            topRight: Radius.circular(42),
          ),
        ),
        builder: (_) => const _Sheet(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _Sheet extends StatefulWidget {
  const _Sheet({Key? key}) : super(key: key);

  @override
  State<_Sheet> createState() => _SheetState();
}

class _SheetState extends State<_Sheet> with SingleTickerProviderStateMixin {
  late final animationController = AnimationController(
    duration: const Duration(milliseconds: 250),
    vsync: this,
  );
  bool _isInAccountCreationMode = false;

  double opacity = 0;

  late final tween = Tween<double>(begin: 0, end: 180).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    ),
  );

  @override
  void initState() {
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 16,
          ),
          AnimatedCrossFade(
            firstChild: const LandingContent(),
            secondChild: const AccountCreationForm(),
            sizeCurve: Curves.easeIn,
            crossFadeState: _isInAccountCreationMode
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250),
          ),
          const SizedBox(
            height: 60,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(42),
                ),
              ),
              onPressed: () {
                animationController.forward();
                _isInAccountCreationMode = true;
                setState(() {
                  opacity = 1;
                });
              },
              child: Container(
                width: 200,
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36.0),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 139, 33, 146)
                          .withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 4), // changes position of shadow
                    ),
                  ],
                  gradient: const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    stops: [0.4, 0.8],
                    colors: [
                      Color.fromARGB(255, 239, 104, 80),
                      Color.fromARGB(255, 139, 33, 146)
                    ],
                  ),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AnimatedCrossFade(
                      firstChild: const Text(
                        'Get started',
                        style: TextStyle(fontSize: 18),
                      ),
                      secondChild: const Text(
                        'Create account',
                        style: TextStyle(fontSize: 16),
                      ),
                      crossFadeState: _isInAccountCreationMode
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 250),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20 + tween.value,
            child: AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(milliseconds: 250),
              child: const Align(
                alignment: Alignment.bottomLeft,
                child: Text('Already have an account? Sign in.'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LandingContent extends StatelessWidget {
  const LandingContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Find local community events",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 42,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          "Get involved with what's happening near you.",
          style: TextStyle(fontSize: 24, color: Colors.blueGrey.shade300),
        )
      ],
    );
  }
}

class AccountCreationForm extends StatelessWidget {
  const AccountCreationForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Create an account",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        SizedBox(
          height: 32,
        ),
        MyTextField(label: 'Email address', icon: Icons.email),
        MyTextField(
          label: 'Password',
          icon: Icons.lock,
          hidden: true,
        ),
      ],
    );
  }
}

class MyTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool hidden;

  const MyTextField({
    Key? key,
    required this.label,
    required this.icon,
    this.hidden = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              cursorColor: Colors.pink.shade400,
              obscureText: hidden,
              autocorrect: !hidden,
              enableSuggestions: !hidden,
              decoration: InputDecoration(
                labelText: label,
                labelStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 18,
                ),
                suffixIcon: Icon(
                  icon,
                  color: Colors.grey.shade400,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pink.shade400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
