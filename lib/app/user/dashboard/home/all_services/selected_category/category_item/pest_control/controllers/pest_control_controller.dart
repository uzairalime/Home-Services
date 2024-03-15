import 'package:get/get.dart';

class PestControlController extends GetxController {
  var insects = ["General", "Cockroaches", "Bed Bugs", "Ants", "Rodents"];
  var flatSize = ["1 BHK ", "2 BHK ", "3 BHK ", "Villa", "Studio"];
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
