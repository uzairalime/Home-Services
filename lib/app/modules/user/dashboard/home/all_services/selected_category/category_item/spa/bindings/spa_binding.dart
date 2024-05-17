import 'package:get/get.dart';

import '../controllers/spa_controller.dart';

class SpaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpaController>(
      () => SpaController(),
    );
  }
}
