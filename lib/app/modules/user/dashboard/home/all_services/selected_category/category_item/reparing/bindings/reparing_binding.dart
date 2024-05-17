import 'package:get/get.dart';

import '../controllers/reparing_controller.dart';

class ReparingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReparingController>(
      () => ReparingController(),
    );
  }
}
