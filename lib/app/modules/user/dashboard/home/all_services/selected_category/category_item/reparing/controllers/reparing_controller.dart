import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReparingController extends GetxController {
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

  TextEditingController numberplatecontroller = TextEditingController();
  var selectedcarbrand = 'Honda'.obs;
  var carbrandList = <String>['Ford F-series', 'Honda', 'Other'];
  var selectedcarModel = 'Civic'.obs;
  var carmodelList = <String>['F-440', 'Civic', 'Other'];

  var terrace = 0.obs;
  var bedroom = 0.obs;
  var bathroom = 0.obs;
  var kitchen = 0.obs;
  var diningRoom = 0.obs;
  var garage = 0.obs;
  RxInt selectedRadio = 0.obs;

  void setSelectedRadio(int index) {
    selectedRadio.value = index;
  }

  var workingHour = 0.obs;

  DateTime today = DateTime.now();

  cleaner_decrese() {
    if (terrace > 0) {
      terrace.value--;
    }
  }

  RxString selectedmaterial = ''.obs;
  void selectMaterials(String material) {
    selectedmaterial.value = material;
  }

  workinH_decr() {
    if (workingHour > 0) {
      workingHour.value--;
    }
  }

  selectdate(DateTime day, DateTime focusedDay) {
    today = day;
    update();
  }



}
