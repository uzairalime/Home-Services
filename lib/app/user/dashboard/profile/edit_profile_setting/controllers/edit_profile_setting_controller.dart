import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileSettingController extends GetxController {
  var selectedDate = DateTime.now();
  String? selectedGender;
  TextEditingController phoneController = TextEditingController();
  TextEditingController fistNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  var genderList = <String>['Male', 'Female', 'Other'];

  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    selectedDate = picked ?? selectedDate;

    update();
  }

  String formattedDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().replaceAll(RegExp(r'^0+(?=.)'), '')}";
  }



}
