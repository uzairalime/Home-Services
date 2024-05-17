import 'package:get/get.dart';

import '../controllers/shifting_controller.dart';

class ShiftingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShiftingController>(
      () => ShiftingController(),
    );
  }
}
