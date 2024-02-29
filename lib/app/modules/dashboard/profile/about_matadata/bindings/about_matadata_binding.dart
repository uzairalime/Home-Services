import 'package:get/get.dart';

import '../controllers/about_matadata_controller.dart';

class AboutMatadataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutMatadataController>(
      () => AboutMatadataController(),
    );
  }
}
