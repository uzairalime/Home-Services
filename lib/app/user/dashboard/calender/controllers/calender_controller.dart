import 'package:get/get.dart';

class CalenderController extends GetxController {
  //TODO: Implement CalenderController

  final count = 0.obs;
  DateTime today = DateTime.now();

  selectdate(DateTime day, DateTime focusedDay) {
    today = day;
    update();
  }




  void increment() => count.value++;
}
