import 'package:get/get.dart';

import '../controllers/edit_istri_controller.dart';

class EditIstriBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditIstriController>(
      () => EditIstriController(),
    );
  }
}
