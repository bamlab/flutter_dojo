import 'dart:ui';

import 'package:bam_dojo/helpers/team_class.dart';
import 'package:bam_dojo/surf/surf.dart';
import 'package:flutter/material.dart';

class SurfTeam3 extends TeamWidget {
  const SurfTeam3({
    Key? key,
  }) : super(key: key, teamName: 'Guillaume & Vincent');

  @override
  Widget build(BuildContext context) {
    final data = SurfData();

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              leading: const _Leading(icon: Icons.arrow_back),
              actions: [_Leading(icon: data.favoriteIcon)],
              expandedHeight: MediaQuery.of(context).size.height * 0.5,
              collapsedHeight: 170,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: const _SpotInfos(),
                  background: Image.network(
                    data.surfUrl,
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: const _Content(),
      ),
    );
  }
}

class _Leading extends StatelessWidget {
  const _Leading({Key? key, required this.icon}) : super(key: key);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final data = SurfData();
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
              color: data.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.all(16),
          child: Icon(icon),
        ),
      ),
    );
  }
}

class _SpotInfos extends StatelessWidget {
  const _SpotInfos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = SurfData();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "SURF SPOT",
            style: TextStyle(fontSize: 10),
          ),
          const Text(
            "Playa de Troya",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
          ),
          Row(
            children: [Icon(data.waveIcon)],
          )
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Great spot for beginners"),
          Text("A popular beach ...."),
          Spacer(),
          Center(
              child: ElevatedButton(
                  onPressed: null, child: Text("check in +10 pointss")))
        ],
      ),
    );
  }
}
