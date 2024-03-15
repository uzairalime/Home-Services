import 'package:get/get.dart';

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
  var selectedServices = <String>['Massage'].obs;

  void toggleSelection(String weekday) {
    if (selectedServices.contains(weekday)) {
      selectedServices.remove(weekday);
    } else {
      selectedServices.add(weekday);
    }
    print(selectedServices);
  }
}
