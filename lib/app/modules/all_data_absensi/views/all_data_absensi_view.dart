import 'package:absensi_project_app/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/all_data_absensi_controller.dart';

class AllDataAbsensiView extends GetView<AllDataAbsensiController> {
  const AllDataAbsensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text('Data Absensi Personil'),
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
