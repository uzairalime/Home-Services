import 'package:get/get.dart';

import '../../../../../../../../../../generated/locales.g.dart';

class SpaController extends GetxController {
  var services = [
    "Massage",
    "Facials",
    "Body Treatments",
    "Manicures and Pedicures",
    "Waxing and Hair Removal",
    "Hydrotherapy",
    "Sauna and Steam Room",
    "Yoga",
    "Meditation Classes",
    "Acupuncture",
    "Cosmetic Treatments",
    "Aromatherapy",
    "Reflexology",
    "Hair Services",
    "Makeup Services"
  ];
  var serviceslabel = [
    LocaleKeys.spa_massage.tr,
    LocaleKeys.spa_facial.tr,
    LocaleKeys.spa_body_treatment.tr,
    LocaleKeys.spa_manicure_pedicure.tr,
    LocaleKeys.spa_waxing_hairremoval.tr,
    LocaleKeys.spa_hydrotherapy.tr,
    LocaleKeys.spa_suana_steam_room.tr,
    LocaleKeys.spa_yoga.tr,
    LocaleKeys.spa_meditation_classes.tr,
    LocaleKeys.spa_acupunture.tr,
    LocaleKeys.spa_reflexology.tr,
    LocaleKeys.spa_hair_services.tr,
    LocaleKeys.spa_makeup_sevices.tr
  ];
  var selectedServices = <String>[LocaleKeys.spa_massage.tr].obs;

  void toggleSelection(String weekday) {
    if (selectedServices.contains(weekday)) {
      selectedServices.remove(weekday);
    } else {
      selectedServices.add(weekday);
    }
    print(selectedServices);
  }
}
