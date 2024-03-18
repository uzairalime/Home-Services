import 'package:get/get.dart';

class WomenSalonController extends GetxController {
  //TODO: Implement WomenSalonController

  RxString selectedweekplan = 'Bridal packages'.obs;

  void selectWeekplan(String plan) {
    selectedweekplan.value = plan;
  }
}
