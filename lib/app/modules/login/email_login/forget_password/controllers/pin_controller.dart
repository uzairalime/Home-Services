import 'dart:convert';
import 'dart:io';


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../../services/apis/toast.dart';
import '../../../../../../utils/otp_resp_model.dart';
import '../../../../../../utils/shared_preferance.dart';
import '../../../../../routes/app_pages.dart';
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

      Map<String, dynamic> postData = {"credential": "+971$phone|$otp", "source": 'mobile'};

      var response = await dio.post(
        'https://homebrigadier.fly.dev/api/token/',
        data: jsonEncode(postData),
      );

      if (response.statusCode == 200) {
        var data = OtpResponseModel.fromJson(response.data);
        // StaticData.accessToken = data.access.toString();
        // StaticData.refreshToken = data.refresh.toString();
        // StaticData.userName = data.username.toString();
        // StaticData.firstName = data.firstName.toString();
        // StaticData.lastName = data.lastName.toString();
        // StaticData.mobile = data.mobile.toString();

        /// store UserPreference
        await SharedPreference.storeUserPreference(access: data.access, refresh: data.refresh);

                 GetStorage _storage= GetStorage();
                 _storage.write("role", role);



                 if(role == "seller"){
                          Get.off(()=>const SellerDashboardView());


                 }else{
              Get.offAllNamed(Routes.DASHBOARD);


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
