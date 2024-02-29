import 'package:get/get.dart';

class CallsController extends GetxController {
  List<String> callItems = List.generate(10, (index) => 'Item ${index + 1}');

  final count = 0.obs;




  void increment() => count.value++;
}
