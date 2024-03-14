import 'package:get/get.dart';

import '../controllers/handyman_controller.dart';

class HandymanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HandymanController>(
      () => HandymanController(),
    );
  }
}
