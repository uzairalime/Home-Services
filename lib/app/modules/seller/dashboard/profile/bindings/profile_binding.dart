import 'package:get/get.dart';

class SellerProfileController extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerProfileController>(
      () => SellerProfileController(),
    );
  }
}
