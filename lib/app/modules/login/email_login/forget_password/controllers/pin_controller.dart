import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/user/dashboard/views/dashboard_view.dart';

import '../../../../../../services/apis/toast.dart';
import '../../../../../../utils/otp_resp_model.dart';
import '../../../../../../utils/shared_preferance.dart';
import '../../../../../seller/dashboard/views/dashboard_view.dart';

class PinController extends GetxController {
  String role = "seller";

  TextEditingController otpController = TextEditingController();
  Dio dio = Dio();

  RxBool isLoading = false.obs;

  Future<void> generateToken({phone, otp}) async {
    try {
      isLoading.value = true;
      update();

      Map<String, dynamic> postData = {
        "credential": "+971$phone|$otp",
        "source": 'mobile'
      };

      var response = await dio.post(
        'https://homebrigadier.fly.dev/api/token/',
        data: jsonEncode(postData),
      );

      if (response.statusCode == 200) {
        var data = OtpResponseModel.fromJson(response.data);

        /// store UserPreference
        await SharedPreference.storeToken(
            access: data.access, refresh: data.refresh);

        // GetStorage _storage = GetStorage();
        // _storage.write("role", role);
        SharedPreference.storeRole(role: "seller");

        if (role == "seller") {
          Get.off(() => const SellerDashboardView());
        } else {
          Get.off(const UserDashboardView());
        }
      }
    } on SocketException catch (_) {
      showsnackbar("Failed to Sign in: Check Internet Connection", true);
    } catch (e) {
      showsnackbar("Failed to Sign in: Try again", true);
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
