import 'package:get/get.dart';

import '../controllers/all_data_absensi_controller.dart';

class AllDataAbsensiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllDataAbsensiController>(
      () => AllDataAbsensiController(),
    );
  }
}
