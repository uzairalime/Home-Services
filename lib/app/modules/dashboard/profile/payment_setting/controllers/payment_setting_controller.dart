import 'package:get/get.dart';

class PaymentSettingController extends GetxController {
  //TODO: Implement PaymentSettingController

  RxInt selectedRadio = 0.obs;

  void setSelectedRadio(int index) {
    selectedRadio.value = index;
  }
}
