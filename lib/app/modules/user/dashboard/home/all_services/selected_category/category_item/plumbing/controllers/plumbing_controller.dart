import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlumbingController extends GetxController {
  TextEditingController insutructioncontroller = TextEditingController();
  var room = 0.obs;
  RxString selectedweekplan = ''.obs;
  void selectWeekplan(String plan) {
    selectedweekplan.value = plan;
  }

  hours_decrese() {
    if (room > 0) {
      room.value--;
    }
  }
}
