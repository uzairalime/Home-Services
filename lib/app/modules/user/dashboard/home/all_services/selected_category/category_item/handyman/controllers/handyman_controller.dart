import 'package:get/get.dart';

import '../../../../../../../../../../generated/locales.g.dart';

class HandymanController extends GetxController {
  var services = [
    LocaleKeys.handy_man_general_repairs.tr,
    LocaleKeys.handy_man_carpentry.tr,
    LocaleKeys.handy_man_tile_work.tr,
    LocaleKeys.handy_man_drywall_repair.tr,
    LocaleKeys.handy_man_flooring.tr,
    LocaleKeys.handy_man_gutter_cleaning.tr,
    LocaleKeys.handy_man_door_reparing.tr,
    LocaleKeys.handy_man_window_repair.tr,
    LocaleKeys.handy_man_assembly.tr,
    LocaleKeys.handy_man_weatherproofing.tr,
    LocaleKeys.handy_man_minor_renovations.tr,
    LocaleKeys.handy_man_general_maintenence.tr,
    LocaleKeys.handy_man_landscaping.tr
  ];
  var selectedServices = 'General Repairs'.obs;

  void toggleSelection(String insect) {
    selectedServices.value = insect;
    update();
  }
}
