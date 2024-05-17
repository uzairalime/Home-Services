import 'package:get/get.dart';

import '../controllers/appliance_controller.dart';

class ApplianceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplianceController>(
      () => ApplianceController(),
    );
  }
}
