import 'package:get/get.dart';

class CategoryItemController extends GetxController {
  final totalimg = 4;
  final count = 0.obs;

  var initialPage = 0;

  chgPage(val) {
    initialPage = val;
    update();
    //print(initialPage);
  }

  void increment() => count.value++;
}
