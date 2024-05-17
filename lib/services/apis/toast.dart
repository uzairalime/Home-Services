import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/consts/app_color.dart';

// showsnackbar(String messege, [bool iserror = false]) {
//   Fluttertoast.showToast(
//       msg: messege,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 1,
//       backgroundColor: iserror ? Colors.red : Colors.green,
//       textColor: Colors.white,
//       fontSize: 16.0);
// }

showSnackBar(String messege, [bool iserror = false]) async {
  Get.showSnackbar(GetSnackBar(
    message: messege,
    snackPosition: SnackPosition.TOP,
    backgroundColor: iserror ? Colors.red : Colors.green,
    duration: const Duration(
      seconds: 2,
    ),
    isDismissible: false,
    // ignore: prefer_const_constructors
    icon: Icon(
      iserror ? Icons.info : Icons.check_circle_sharp,
      color: AppColor.white,
    ),
  ));
}
