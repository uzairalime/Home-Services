import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/services/apis/api_endpoints.dart';
import 'package:home_brigadier/services/apis/toast.dart';

import '../../seller/dashboard/profile/language_setting/controllers/language_setting_controller.dart';

class EmailLoginController extends GetxController {
  final langObj = Get.put(LanguageSettingController());
  TextEditingController phoneController = TextEditingController();
  var phoneFocus = false.obs;
  RxBool isLoading = false.obs;

  Dio dio = Dio();

  void onRateFocus(value) {
    phoneFocus.value = value;
  }

  @override
  void onInit() {
    update();
    super.onInit();
  }

  Future<int?> generateOTP() async {
    isLoading.value = true;
    update();
    try {
      Map<String, dynamic> postData = {"mobile": "+971${phoneController.text}"};

      // print(jsonEncode(postData));
      var response = await dio.post(
          ApiEndpoints.BASEURL + ApiEndpoints.GENERATE_OTP,
          data: jsonEncode(postData));

      return response.statusCode;
    } on SocketException catch (_) {
      showSnackBar("Failed to Sign in: Check Internet Connection");
      //print('SocketException: $e');
    } catch (e) {
      // showSnackBar("Failed to Sign in: Try again");
      // print('Error posting data: $e');
    } finally {
      isLoading.value = false;
      update();
    }
    return null;
  }

  Future<void> setSelectedLanguage(String? language) async {
    langObj.setSelectedLanguage(language);
    update();
  }
}
