import 'package:get/get.dart';

import '../controllers/women_salon_controller.dart';

class WomenSalonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WomenSalonController>(
      () => WomenSalonController(),
    );
  }
}
