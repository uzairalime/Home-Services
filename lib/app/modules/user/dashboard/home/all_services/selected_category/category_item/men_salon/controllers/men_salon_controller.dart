import 'package:get/get.dart';

import '../../../../../../../../../../generated/locales.g.dart';

class MenSalonController extends GetxController {
  static MenSalonController get to => Get.find();
  RxString selectedweekplan = ''.obs;

  void selectWeekplan(String plan) {
    selectedweekplan.value = plan;
  }

  var insectlabel = [
    LocaleKeys.men_saloon_hair_cut_formen.tr,
    LocaleKeys.men_saloon_hair_beard_color.tr,
    LocaleKeys.men_saloon_chest_back_trimming.tr,
    LocaleKeys.men_saloon_express_massage.tr,
    LocaleKeys.men_saloon_face_care.tr,
    LocaleKeys.men_saloon_pedicure.tr,
    LocaleKeys.men_saloon_face_waxing.tr,
    LocaleKeys.men_saloon_shave_beard.tr,
  ];
  // var flatSize = ["1 BHK ", "2 BHK ", "3 BHK ", "Villa", "Studio"];
  var selectedInsects = <String>[
    LocaleKeys.men_saloon_hair_cut_formen.tr,
  ].obs;
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
