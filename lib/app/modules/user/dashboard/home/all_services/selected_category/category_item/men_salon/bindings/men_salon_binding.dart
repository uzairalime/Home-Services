import 'package:get/get.dart';

import '../controllers/men_salon_controller.dart';

class MenSalonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenSalonController>(
      () => MenSalonController(),
    );
  }
}
