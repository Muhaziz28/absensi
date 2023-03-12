import 'package:get/get.dart';

import '../controllers/edit_anak_controller.dart';

class EditAnakBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditAnakController>(
      () => EditAnakController(),
    );
  }
}
