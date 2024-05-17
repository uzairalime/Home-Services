import 'package:get/get.dart';

import '../controllers/plumbing_controller.dart';

class PlumbingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlumbingController>(
      () => PlumbingController(),
    );
  }
}
