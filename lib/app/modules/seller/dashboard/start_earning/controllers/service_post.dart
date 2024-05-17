import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as deo;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../consts/static_data.dart';
import '../../../../../../model/user_services_models/my_service_post_model.dart';
import '../../../../../../services/apis/api_endpoints.dart';
import '../../../../../../services/apis/toast.dart';
import '../../../../../../utils/animation_dialog.dart';
import '../../controllers/dashboard_controller.dart';

class PostService {
  static deo.Dio dio = deo.Dio();
  static final con = Get.put(SellerDashboardController());

  static Future<int?> postMyService(
      {required context,
      required String name,
      required String description,
      required String category,
      required String address,
      required String location,
      required List<String> fileId,
      required List<String> weekDays,
      required String from_hour,
      required String to_hour,
      required String rate}) async {
    MyServicesPostModel model = MyServicesPostModel();
    dio.options.headers['Authorization'] = 'Bearer ${StaticData.accessToken}';
    List<PostOpeningHours> openingHours = [];

    for (var i in weekDays) {
      openingHours.add(PostOpeningHours(
          weekday: i.toString(),
          fromHour: from_hour.toString(),
          toHour: to_hour.toString()));
    }

    model = MyServicesPostModel(
        name: name.toString(),
        description: description.toString(),
        category: category.toString().trim(),
        address: address.toString(),
        files: fileId,
        location: location.toString(),
        openingHours: openingHours,
        rate: rate.toString());

    log(StaticData.accessToken);
    log(jsonEncode(model));

    try {
      final response = await dio.post(
        ApiEndpoints.BASEURL + ApiEndpoints.SERVICE,
        data: jsonEncode(model),
      );
      if (response.statusCode == 201) {
        // showsnackbar("Service add Successfully");
        // Get.to(() => const UserProfileView());
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const AnimationDialog(
                  text: 'Successfully Added !',
                )).then((value) {
          con.changePage(2);
          con.update();
        });
      }
    } on SocketException catch (_) {
      showSnackBar("Error: Check Internet Connection", true);

      // print("SocketException: $e");
    } catch (e) {
      log(e.toString());
      showSnackBar("Failed to Upload: Try again", true);

      //print("Error: $e");
    }
    return null;
  }
}
