import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:absensi_project_app/theme.dart';
import '../controllers/tunjangan_kinerja_controller.dart';

class TunjanganKinerjaView extends GetView<TunjanganKinerjaController> {
  const TunjanganKinerjaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text('Tunjangan Kinerja'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Center(
        child: Lottie.network(
            'https://assets5.lottiefiles.com/private_files/lf30_y9czxcb9.json'),
      ),
    );
  }
}
