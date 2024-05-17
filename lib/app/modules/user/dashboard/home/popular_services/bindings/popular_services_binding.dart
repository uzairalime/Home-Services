import 'package:get/get.dart';

import '../controllers/popular_services_controller.dart';

class PopularServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PopularServicesController>(
      () => PopularServicesController(),
    );
  }
}
