import 'package:get/get.dart';

import '../controllers/pest_control_controller.dart';

class PestControlBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PestControlController>(
      () => PestControlController(),
    );
  }
}
