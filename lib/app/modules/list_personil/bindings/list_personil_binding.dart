import 'package:get/get.dart';

import '../controllers/list_personil_controller.dart';

class ListPersonilBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListPersonilController>(
      () => ListPersonilController(),
    );
  }
}
