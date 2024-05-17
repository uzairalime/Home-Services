import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LaundryController extends GetxController {
  TextEditingController weightcontroller = TextEditingController();
  var fragranceservice = 'Yes'.obs;
  var fragranceList = <String>[
    'Yes',
    'No',
  ];
  var selectedservice = 'Yes'.obs;
  var serviceList = <String>[
    'Yes',
    'No',
  ];
}
