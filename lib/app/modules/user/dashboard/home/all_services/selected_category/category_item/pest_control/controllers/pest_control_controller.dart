import 'package:get/get.dart';

import '../../../../../../../../../../generated/locales.g.dart';

class PestControlController extends GetxController {
  // var insects = ["General", "Cockroaches", "Bed Bugs", "Ants", "Rodents"];
  var flatsizelabel = [
    LocaleKeys.pest_control_1_bhk.tr,
    LocaleKeys.pest_control_2_bkh.tr,
    LocaleKeys.pest_control_3_bkh.tr,
    LocaleKeys.pest_control_villa.tr,
    LocaleKeys.pest_control_studio.tr
  ];
  var insectlabel = [
    LocaleKeys.pest_control_general.tr,
    LocaleKeys.pest_control_cockroaches.tr,
    LocaleKeys.pest_control_bed_bugs.tr,
    LocaleKeys.pest_control_ants.tr,
    LocaleKeys.pest_control_rodent.tr
  ];
  // var flatSize = ["1 BHK ", "2 BHK ", "3 BHK ", "Villa", "Studio"];
  var selectedInsects = <String>['General'].obs;
  var selectedSize = '1 BHK'.obs;

  void toggleSelection(String weekday) {
    if (selectedInsects.contains(weekday)) {
      selectedInsects.remove(weekday);
    } else {
      selectedInsects.add(weekday);
    }
    print(selectedInsects);
  }
}
