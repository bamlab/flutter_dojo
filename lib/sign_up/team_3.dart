import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class SignUpTeam3 extends TeamWidget {
  const SignUpTeam3({
    Key? key,
  }) : super(key: key, teamName: 'Guillaume');

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
    return SizedBox(
      height: 500,
      child: Image.asset(
        'assets/images/background.png',
        fit: BoxFit.fitHeight,
      ),
    );
  }
}

class _Sheet extends StatefulWidget {
  const _Sheet({Key? key}) : super(key: key);

  @override
  State<_Sheet> createState() => _SheetState();
}

class _SheetState extends State<_Sheet> {
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final double progress =
        pageController.hasClients ? ((pageController.page ?? 0)) : 0;
    final double height = 400 + progress * 140;

    return SizedBox(
      height: height,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: PageView(
                  controller: pageController,
                  children: const [
                    LandingContent(),
                    _AccountCreationForm(),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: 16,
            bottom: 32 + progress * 140,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(42),
                ),
              ),
              onPressed: () {
                pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                );
              },
              child: FAB(
                progress: progress,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FAB extends StatelessWidget {
  const FAB({
    Key? key,
    required this.progress,
  }) : super(key: key);

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36.0),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 139, 33, 146).withOpacity(0.3),
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
          Stack(
            fit: StackFit.passthrough,
            children: [
              Opacity(
                opacity: 1 - progress,
                child: const Text(
                  'Get started',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(
                width: 80 + progress * 36,
                child: Opacity(
                  opacity: 0 + progress,
                  child: const Text(
                    'Create account',
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          const Icon(
            Icons.chevron_right,
            size: 24,
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
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
      ),
    );
  }
}

class _AccountCreationForm extends StatelessWidget {
  const _AccountCreationForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create an account",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            const _TextField(label: 'Email address', icon: Icons.email),
            const SizedBox(
              height: 16,
            ),
            const _TextField(
              label: 'Password',
              icon: Icons.lock,
              hidden: true,
            ),
            const SizedBox(
              height: 200,
            ),
            Text(
              "Already have an account? Sign in.",
              style: TextStyle(fontSize: 16, color: Colors.blueGrey.shade300),
            )
          ],
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool hidden;

  const _TextField({
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
