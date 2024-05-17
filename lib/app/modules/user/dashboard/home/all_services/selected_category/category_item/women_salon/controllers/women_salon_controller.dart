import 'package:get/get.dart';

import '../../../../../../../../../../generated/locales.g.dart';

class WomenSalonController extends GetxController {
  //TODO: Implement WomenSalonController

  RxString selectedweekplan = 'Bridal packages'.obs;

  void selectWeekplan(String plan) {
    selectedweekplan.value = plan;
  }

  var insectlabel = [
    LocaleKeys.women_saloon_bridal_package.tr,
    LocaleKeys.women_saloon_skin_treatment.tr,
    LocaleKeys.women_saloon_face_waxing.tr,
    LocaleKeys.women_saloon_pedicure.tr,
    LocaleKeys.women_saloon_express_massage.tr,
    LocaleKeys.women_saloon_hair_removing.tr,
    LocaleKeys.women_saloon_threading.tr
  ];
  // var flatSize = ["1 BHK ", "2 BHK ", "3 BHK ", "Villa", "Studio"];
  var selectedInsects = <String>[
    LocaleKeys.women_saloon_bridal_package.tr,
  ].obs;

  void toggleSelection(String weekday) {
    if (selectedInsects.contains(weekday)) {
      selectedInsects.remove(weekday);
    } else {
      selectedInsects.add(weekday);
    }
    print(selectedInsects);
  }
}
