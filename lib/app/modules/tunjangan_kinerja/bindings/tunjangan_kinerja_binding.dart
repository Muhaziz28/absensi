import 'package:get/get.dart';

import '../controllers/tunjangan_kinerja_controller.dart';

class TunjanganKinerjaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TunjanganKinerjaController>(
      () => TunjanganKinerjaController(),
    );
  }
}
