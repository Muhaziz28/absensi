import 'package:get/get.dart';

import '../controllers/data_kepolisian_controller.dart';

class DataKepolisianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataKepolisianController>(
      () => DataKepolisianController(),
    );
  }
}
