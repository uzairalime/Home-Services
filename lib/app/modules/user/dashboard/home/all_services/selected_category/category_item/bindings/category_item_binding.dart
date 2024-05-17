import 'package:get/get.dart';

import '../controllers/category_item_controller.dart';

class CategoryItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryItemController>(
      () => CategoryItemController(),
    );
  }
}
