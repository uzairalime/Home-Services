import 'package:get/get.dart';

import '../controllers/payment_setting_controller.dart';

class PaymentSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentSettingController>(
      () => PaymentSettingController(),
    );
  }
}
