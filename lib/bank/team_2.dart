import 'package:bam_dojo/helpers/team_class.dart';
import 'package:flutter/material.dart';

class BankTeam2 extends TeamWidget {
  const BankTeam2({
    Key? key,
  }) : super(key: key, teamName: 'Valentin & Louis');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BankAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: const [
            Text(
              'Send Money',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Send To',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(height: 10),
            BankUserCard()
          ],
        ),
      ),
    );
  }
}

class BankAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BankAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(48);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: false,
      elevation: 0,
      leading: const _BankButton(
        icon: Icons.arrow_back,
      ),
      title: const Text(
        'Back',
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
      actions: const [
        _BankButton(icon: Icons.ring_volume_outlined),
        SizedBox(width: 20)
      ],
    );
  }
}

class _BankButton extends StatelessWidget {
  const _BankButton({
    Key? key,
    required this.icon,
  }) : super(key: key);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black12),
      ),
      child: Icon(
        icon,
        color: Colors.black,
      ),
    );
  }
}

class BankUserCard extends StatelessWidget {
  const BankUserCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 120, 125, 128).withOpacity(0.15),
            offset: const Offset(0, 25),
            blurRadius: 20,
          ),
        ],
      ),
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            const SizedBox(
              height: 50,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://cdn.shopify.com/s/files/1/1286/1203/collections/snoopy-logo.png?v=1631603428',
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Daniel de Snoopy',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '+32 324 5561 8761',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
            const Spacer(),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
