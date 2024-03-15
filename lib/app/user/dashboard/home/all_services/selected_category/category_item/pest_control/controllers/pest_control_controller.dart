import 'package:get/get.dart';

class PestControlController extends GetxController {
  var insects = ["General", "Cockroaches", "Bed Bugs", "Ants", "Rodents"];
  var selectedInsects = <String>['General'].obs;

  void toggleSelection(String weekday) {
    if (selectedInsects.contains(weekday)) {
      selectedInsects.remove(weekday);
    } else {
      selectedInsects.add(weekday);
    }
    print(selectedInsects);
  }
}
