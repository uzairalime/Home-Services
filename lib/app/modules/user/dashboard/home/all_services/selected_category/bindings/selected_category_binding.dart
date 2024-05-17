import 'package:get/get.dart';

import '../controllers/selected_category_controller.dart';

class SelectedCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectedCategoryController>(
      () => SelectedCategoryController(),
    );
  }
}
