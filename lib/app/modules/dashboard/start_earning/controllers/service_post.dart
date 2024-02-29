import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as deo;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/modules/dashboard/profile/user_profile/views/user_profile_view.dart';
import 'package:home_brigadier/model/user_services_models/my_service_post_model.dart';
import 'package:home_brigadier/services/apis/toast.dart';
import 'package:home_brigadier/utils/animation_dialog.dart';

import '../../../../../consts/static_data.dart';

class PostService {
  static deo.Dio dio = deo.Dio();

  static Future<int?> postMyService(
      {
        
        required context,
        
        required String name,
      required String description,
      required String category,
      required String address,
      required String location,
      required String fileId,
      required List<String> weekDays,
      required String from_hour,
      required String to_hour,
      required String rate}) async {
    MyServicesPostModel model = MyServicesPostModel();
    dio.options.headers['Authorization'] = 'Bearer ${StaticData.accessToken}';
    List<PostOpeningHours> openingHours = [];

    for (var i in weekDays) {
      openingHours.add(PostOpeningHours(
          weekday: i.toString(), fromHour: from_hour.toString(), toHour: to_hour.toString()));
    }

    model = MyServicesPostModel(
        name: name.toString(),
        description: description.toString(),
        category: category.toString().trim(),
        address: address.toString(),
        files: [fileId.toString()],
        location: location.toString(),
        openingHours: openingHours,
        rate: rate.toString());

    // print(jsonEncode(model));

    try {
      final response = await dio.post(
        "https://homebrigadier.fly.dev/api/service/",
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
          Get.to(() => const UserProfileView());
        });
      }
    } on SocketException catch (_) {
      showsnackbar("Error: Check Internet Connection");

      // print("SocketException: $e");
    } catch (e) {
      showsnackbar("Failed to Upload: Try again");

      //print("Error: $e");
    }
    return null;
  }
}
