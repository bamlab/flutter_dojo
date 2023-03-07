import 'package:bam_dojo/helpers/team_class.dart';
import 'package:bam_dojo/reflective_cd/reflective_cd.dart';
import 'package:flutter/material.dart';

class ReflectiveCDTeam1 extends StatefulWidget with TeamMixin {
  final teamName = 'Team1';

  @override
  State<ReflectiveCDTeam1> createState() => _ReflectiveCDTeam1State();
}

class _ReflectiveCDTeam1State extends State<ReflectiveCDTeam1> {
  // late CameraController controller;

  // @override
  // void initState() {
  //   super.initState();
  //   // availableCameras().then((value) {
  //   //   controller = CameraController(value[0], ResolutionPreset.low);
  //   //   controller.initialize().then((_) {
  //   //     if (!mounted) {
  //   //       return;
  //   //     }
  //   //     setState(() {});
  //   //   }).catchError((Object e) {
  //   //     if (e is CameraException) {
  //   //       switch (e.code) {
  //   //         case 'CameraAccessDenied':
  //   //           // Handle access errors here.
  //   //           break;
  //   //         default:
  //   //           // Handle other errors here.
  //   //           break;
  //   //       }
  //   //     }
  //   //   });
  //   // });
  // }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // if (!controller.value.isInitialized) {
    //   return const Center(child: CircularProgressIndicator());
    // }
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
      child: Stack(
        children: [
          Image.asset('assets/images/cd_case.jpg'),
          Opacity(opacity: 0.2, child: Image.asset('assets/images/image.png')),
        ],
      ),
    );
  }
}
