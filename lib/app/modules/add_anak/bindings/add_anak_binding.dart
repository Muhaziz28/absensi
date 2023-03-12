import 'package:get/get.dart';

import '../controllers/add_anak_controller.dart';

class AddAnakBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddAnakController>(
      () => AddAnakController(),
    );
  }
}
