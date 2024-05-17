import 'package:get/get.dart';

import '../controllers/start_earning_controller.dart';

class StartEarningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StartEarningController>(
      () => StartEarningController(),
    );
  }
}
