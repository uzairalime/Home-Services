import 'package:get/get.dart';

class MenSalonController extends GetxController {
  static MenSalonController get to => Get.find();
  RxString selectedweekplan = ''.obs;

  void selectWeekplan(String plan) {
    selectedweekplan.value = plan;
  }
}
