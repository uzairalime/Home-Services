import 'package:get/get.dart';

class HandymanController extends GetxController {
  var services = [
    "General Repairs",
    "Carpentry",
    "Tile Work",
    "Drywall Repair",
    "Flooring",
    "Gutter Cleaning",
    "Door Repair",
    "Window Repair",
    "Assembly",
    "Weatherproofing",
    "Minor Renovations",
    "General Maintenance",
    "Landscaping"
  ];
  var selectedServices = 'General Repairs'.obs;

  void toggleSelection(String insect) {
    selectedServices.value = insect;
    update();
  }
}
