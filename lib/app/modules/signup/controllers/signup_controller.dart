import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/model/phone_auth_model/phone_auth_post_model.dart';
import 'package:home_brigadier/services/apis/api_endpoints.dart';
import 'package:home_brigadier/services/apis/api_helper.dart';


class SignupController extends GetxController {
  //TODO: Implement SignupController
  final apiHelper = ApiHelper();

  final count = 0.obs;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  bool isremindme = false;

  changeRemindme(val) {
    isremindme = val;
    update();
  }

  bool isobx = true;

  changeObx() {
    isobx = !isobx;
    update();
  }

  phoneAuth() async {
    final userInfo = UserInfo(firstName: "adil", lastName: "Khan");
    final postDataModel = PhoneAuthPostModel(
        source: "mobile", credential: "+971501120272", userInfo: userInfo);

    var response = await apiHelper.post(TOKEN, postDataModel);
    print("response $response");
  }

  @override
  void onClose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.onClose();
  }
}
