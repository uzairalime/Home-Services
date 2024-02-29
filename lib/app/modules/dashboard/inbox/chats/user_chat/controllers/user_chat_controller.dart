import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserChatController extends GetxController {
  //TODO: Implement UserChatController

  TextEditingController smsController = TextEditingController();

  final count = 0.obs;




  void increment() => count.value++;
}
