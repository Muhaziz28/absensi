import 'package:absensi_project_app/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/data_kepolisian_controller.dart';

class DataKepolisianView extends GetView<DataKepolisianController> {
  const DataKepolisianView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Data Kepolisian'),
        centerTitle: true,
      ),
      body: Center(
        child: Lottie.network(
            'https://assets5.lottiefiles.com/private_files/lf30_y9czxcb9.json'),
      ),
    );
  }
}
