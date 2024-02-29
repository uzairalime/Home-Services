import 'package:get/get.dart';

import '../controllers/security_setting_controller.dart';

class SecuritySettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SecuritySettingController>(
      () => SecuritySettingController(),
    );
  }
}
