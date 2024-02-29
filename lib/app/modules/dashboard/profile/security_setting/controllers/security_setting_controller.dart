import 'package:get/get.dart';

class SecuritySettingController extends GetxController {
  RxBool rememberSwitch = false.obs;
  RxBool faceIdSwitch = false.obs;
  RxBool bioMetricSwitch = false.obs;

  void securitySwitch({required String title, required bool value}) {
    switch (title) {
      case "Remember me":
        rememberSwitch.value = value;
        break;
      case "Face ID":
        faceIdSwitch.value = value;
        break;
      case "Biometric ID":
        bioMetricSwitch.value = value;
        break;
    }
  }
}
