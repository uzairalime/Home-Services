import 'package:get/get.dart';

import '../controllers/edit_profile_setting_controller.dart';

class EditProfileSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileSettingController>(
      () => EditProfileSettingController(),
    );
  }
}
