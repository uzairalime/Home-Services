import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  //TODO: Implement ForgetPasswordController
  TextEditingController reenterpassword = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController otpController = TextEditingController();
  Dio dio = Dio();

  bool isremindme = false;
  RxBool isLoading = false.obs;

  changeRemindme(val) {
    isremindme = val;
    update();
  }

  bool isobx1 = true;
  changeObx() {
    isobx1 = !isobx1;
    update();
  }

  // Reenter password
  bool isobx2 = true;
  changeObx2() {
    isobx2 = !isobx2;
    update();
  }

  bool issms = false;
  bool isemail = false;
  void sms() {
    issms = !issms;
    isemail = false;
    update();
  }

  void email() {
    isemail = !isemail;
    issms = false;
    update();
  }

  @override
  void onClose() {
    passwordcontroller.dispose();
    reenterpassword.dispose();
    super.onClose();
  }
}
