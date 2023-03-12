import 'package:get/get.dart';

import '../controllers/add_riwayat_pendidikan_controller.dart';

class AddRiwayatPendidikanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddRiwayatPendidikanController>(
      () => AddRiwayatPendidikanController(),
    );
  }
}
