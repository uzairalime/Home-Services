import 'package:get/get.dart';

class ApplianceController extends GetxController {
  RxBool iswashingmachine = false.obs;
  changemac(val) {
    iswashingmachine.value = val;
    update();
  }

  RxBool isrefrigetaor = false.obs;
  changeref(val) {
    isrefrigetaor.value = val;
    update();
  }

  RxBool isdis_ = false.obs;
  changedis(val) {
    isdis_.value = val;
    update();
  }

  RxBool iscond_ = false.obs;
  changecond(val) {
    iscond_.value = val;
    update();
  }

  RxBool isgrilli_ = false.obs;
  changegrilli(val) {
    isgrilli_.value = val;
    update();
  }

  RxBool iswasher = false.obs;
  changewasher(val) {
    iswasher.value = val;
    update();
  }

  RxBool isdrayer_ = false.obs;
  changedrayer(val) {
    isdrayer_.value = val;
    update();
  }

  RxBool isngmachine_ = false.obs;
  changemachine(val) {
    isngmachine_.value = val;
    update();
  }
}
