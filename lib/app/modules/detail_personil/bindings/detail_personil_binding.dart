import 'package:get/get.dart';

import '../controllers/detail_personil_controller.dart';

class DetailPersonilBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPersonilController>(
      () => DetailPersonilController(),
    );
  }
}
