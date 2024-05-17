import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/consts/static_data.dart';

import '../../../../../../services/apis/api_endpoints.dart';
import '../../../../../../services/apis/toast.dart';
import '../../../../../../utils/otp_resp_model.dart';
import '../../../../../../utils/shared_preferance.dart';
import '../../../seller/dashboard/views/dashboard_view.dart';
import '../../../user/dashboard/home/all_services/selected_category/category_item/house_cleaning/views/location_view.dart';

class PinController extends GetxController {
  @override
  void onInit() {
    SharedPreference.getRole();
    super.onInit();
  }

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
        ApiEndpoints.BASEURL + ApiEndpoints.TOKEN,
        data: jsonEncode(postData),
      );

      if (response.statusCode == 200) {
        var data = OtpResponseModel.fromJson(response.data);

        /// store UserPreference
        await SharedPreference.storeToken(
            access: data.access, refresh: data.refresh);

        if (StaticData.role == "seller") {
          Get.offAll(() => const SellerDashboardView());
        } else {
          Get.to(() => const LocationView());
        }
      }
    } on SocketException catch (_) {
      showSnackBar("Failed to Sign in: Check Internet Connection", true);
    } catch (e) {
      showSnackBar("Failed to Sign in: Try again", true);
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
