import 'package:get/get.dart';

class ChatsController extends GetxController {
  List<String> items = List.generate(10, (index) => 'Item ${index + 1}');
  Rx<RxSet<int>> selectedItems = RxSet<int>().obs; // Using RxSet for reactivity

  markItem(int index) {
    if (selectedItems.value.contains(index)) {
      selectedItems.value.remove(index);
    } else {
      selectedItems.value.add(index);
    }
    update();
  }

  final count = 0.obs;




  void increment() => count.value++;
}
